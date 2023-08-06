Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3677159F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjHFO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHFO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:28:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66E9F;
        Sun,  6 Aug 2023 07:28:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9338e4695so58510411fa.2;
        Sun, 06 Aug 2023 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691332090; x=1691936890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjOqtzjiS9hMriytx4md9WAGNQMkIBNRRc2C+laXxqo=;
        b=GZCXdTuinDdxp+PAbXVrD2C6/E4RbzF3nAUZHcD921R7oKjcEwTAL68I/Ks7yYu1GC
         br3UoyGRCP6WXowXCDj7G74fYjvUxDIUV/HOT/JiWJQDU67qEOLTEXa71tFwYtUD3AqH
         +bmGcAo9Ss02jOWwFfsZsF0HenAZqCeTVfom62/3MimZhq6SXaz8FfBBpWFHOgKDx+hz
         SyNFrqzgEoaDRVHGPHJvQp6wudTwM7XcsEfz2H+z6siZuaSBTaucQWbSZatzJHOFtSKA
         K5q82pMyR1W++pmG99GgnYu1fDerVKKt/8TPXUSMObA1UIBAjxX6JHpD8nK262FM7E5u
         S8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691332090; x=1691936890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjOqtzjiS9hMriytx4md9WAGNQMkIBNRRc2C+laXxqo=;
        b=N7KWx1C6rjpTGz0eqXJlvQoL8qQ6sD+JkuS+BzOdqrZ/h9CcvtYTe6yJ0uuCEEQcbO
         ZS0bGtI/qJf8zGc9ThF63YhipKb0YtKBpRuBAvHgkyFUdyN8mBWmHxtySIS31d0V5kTL
         l2pQabhQEocChqg0PmkximgruuTaPoB6TV7Ovd2K4Q7G6CAFpcf3k0fiM2D3/6rBp3ZV
         Mlk7q1UVjLyu+fMNT5o1VIsCscUZSyVNPSIRIYvwENLMa6RfiDPMGYNBIQioJXC1C48h
         m/nMJQ2F3Kraz4X5QBBJr0n+3msVu45hWY+ZtJDN4HfbQPEec5/ji6AGIep7CwCjhMyy
         Vj5A==
X-Gm-Message-State: AOJu0YwHKbSPH58wgdVwATcVAPf5AKRUx95euQbAW5wIePiANI9Ew5cr
        eh0KsXWKnvN1LAvBqR5Goq9yKo8LYO6XbQ==
X-Google-Smtp-Source: AGHT+IHQS5XGNzu/GSaoZhX74O3EBI5ek2XmGXif/BZeiwcZSNC8aG/8xU72RZqu3pk51DyK4m7NyQ==
X-Received: by 2002:a19:9103:0:b0:4fd:d6ba:73c2 with SMTP id t3-20020a199103000000b004fdd6ba73c2mr4203961lfd.54.1691332089593;
        Sun, 06 Aug 2023 07:28:09 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005222b471dc4sm3909677edy.95.2023.08.06.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 07:28:09 -0700 (PDT)
Date:   Sun, 6 Aug 2023 16:28:08 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: confused about kprobes
Message-ID: <ZM+t+EVXIlNbKZ3u@nam-dell>
References: <ZM+BhEz9u7hrWe6e@nam-dell>
 <20230806213150.5571b4a7f4a0531fcb00f689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806213150.5571b4a7f4a0531fcb00f689@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 09:31:50PM +0900, Masami Hiramatsu wrote:
> Hi Nam,
> 
> On Sun, 6 Aug 2023 13:18:28 +0200
> Nam Cao <namcaov@gmail.com> wrote:
> 
> > Hello,
> > 
> > I am struggling to understand how kprobes works. It would be very nice if someone
> > can spare the time to explain to me. I'm confused about this function in particular:
> > 
> > /*
> >  * Return an optimized kprobe whose optimizing code replaces
> >  * instructions including 'addr' (exclude breakpoint).
> >  */
> > static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
> > {
> > 	int i;
> > 	struct kprobe *p = NULL;
> > 	struct optimized_kprobe *op;
> > 
> > 	/* Don't check i == 0, since that is a breakpoint case. */
> > 	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> > 		p = get_kprobe(addr - i);
> > 
> > 	if (p && kprobe_optready(p)) {
> > 		op = container_of(p, struct optimized_kprobe, kp);
> > 		if (arch_within_optimized_kprobe(op, addr))
> > 			return p;
> > 	}
> > 
> > 	return NULL;
> > }
> > 
> > The document mentions something about optimizing by replacing trap instructions
> > with jump instructions, so I am assuming this function is part of that.
> 
> Yes, you're right. 
> 
> > But I
> > fail to see what this function is trying to do exactly. The for loop seems to
> > call get_kprobe at addresses immediately before "addr". But what for? What are
> > at addresses before "addr"?
> 
> This is for finding a jump optimized kprobe which will modify the instruction
> pointed by 'addr'. As you may know, on x86, the software-breakpoint
> instruction is 1 byte, but the jump will be 5 bytes. In that case, if we put
> something at instruction including 'addr', it will be ignored or it will break
> the jump instruction. So it is used for finding such optimized kprobe.
> 
> For the kprobe, the jump optimization is optional and hidden from the user. We
> should prioritize adding kprobes at specified locations over optimization.
> Thus if we find such optimized kprobe, it must be unoptimized.

Thank you so much for the detailed answer, it is clear now.

Best regards,
Nam
