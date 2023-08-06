Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD0771481
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHFLSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFLSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:18:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E1A11D;
        Sun,  6 Aug 2023 04:18:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso5001692a12.3;
        Sun, 06 Aug 2023 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691320710; x=1691925510;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=je1gUzvwrqcKGyu+CaM6BhOeHMrmqE7jvTrxfdtVg+c=;
        b=UvsSgM4LoSJAa2mNOuJ5Iv+oGAdwD62Wt2/PMYqnAp5neD4L6dS9zXu691t5xo58sN
         +C8PqdPEik2VvfsCwtfpfai7q0JBWIzQY44Fj2ACxHdUp00GfP2S53aGEgNbX7jAzCwT
         W4xpjwz5ElfF/Ao68gjWd5UewvEQbasIbqOcpx1Qw3Fok1mmdG64P9G1qldeIL2Nh51G
         IlHGJqKYWi9pyUGaFWNBZELA0cWLZV/lhwxjB7A7UafOevLtAOFbuIxIznzVFSJs2fZR
         AXAurc7zxFrnpEAVTTriOSKoVXxKOOnGNtWSJbqjaq9/vMoQ+OrMCkD+liGwkjtQG+Hw
         sEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691320710; x=1691925510;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je1gUzvwrqcKGyu+CaM6BhOeHMrmqE7jvTrxfdtVg+c=;
        b=JI+zgumFKD6tNs15MA0Nnv3DgQ+M3bSdFK3LYveJijvWtlI4sLmWzTvLPEwkd5Bu8F
         JHR+qMysfYgqr4g74trCJEnEQyUm/945qQ6eoSvtmxeigkzz4SVQye5sXK7D7PIzjqyT
         JXKquoQxt1JvYm5vTIOIYdeEwiSDMjKCEOxkHKGLvPdM6y4kO3cnaVl4J8inm/txQNko
         JOEmW2PpkKeHx1X9Ka2oKssF3jUlIL8Wcx63BY2Hf69mLM2R7hSgtbtj7Fl7PSI3+NW5
         bqWaDyL710S059rL9hQwpYIsOY5b1rqx8q8q4wQOYww1hrD8UAvTpTBxLM5vsXoB+++X
         /nyQ==
X-Gm-Message-State: AOJu0Yy7vESyBuEVB5pHEtzrJLUUPYpG51H1yG0+dEgqu5C2+U4bmCeE
        C2Ja5O+k3frsLKJs7RsX0OAb8E+d/i2J7w==
X-Google-Smtp-Source: AGHT+IFgigO3y9Y0gmsVwp0bgkTt8PTWPfzi/5MWxrUz9PiEfM72eh/jIwxL/bbaITEl5Qt+H97tpg==
X-Received: by 2002:a05:6402:54:b0:522:30cc:a1f0 with SMTP id f20-20020a056402005400b0052230cca1f0mr5720629edu.14.1691320710452;
        Sun, 06 Aug 2023 04:18:30 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402015900b0052237dfa82fsm3769409edu.64.2023.08.06.04.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 04:18:29 -0700 (PDT)
Date:   Sun, 6 Aug 2023 13:18:28 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: confused about kprobes
Message-ID: <ZM+BhEz9u7hrWe6e@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am struggling to understand how kprobes works. It would be very nice if someone
can spare the time to explain to me. I'm confused about this function in particular:

/*
 * Return an optimized kprobe whose optimizing code replaces
 * instructions including 'addr' (exclude breakpoint).
 */
static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
{
	int i;
	struct kprobe *p = NULL;
	struct optimized_kprobe *op;

	/* Don't check i == 0, since that is a breakpoint case. */
	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
		p = get_kprobe(addr - i);

	if (p && kprobe_optready(p)) {
		op = container_of(p, struct optimized_kprobe, kp);
		if (arch_within_optimized_kprobe(op, addr))
			return p;
	}

	return NULL;
}

The document mentions something about optimizing by replacing trap instructions
with jump instructions, so I am assuming this function is part of that. But I
fail to see what this function is trying to do exactly. The for loop seems to
call get_kprobe at addresses immediately before "addr". But what for? What are
at addresses before "addr"?

Can someone be so kind to give me a line-by-line explanation of this function?

Thanks!

Nam
