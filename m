Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C17D852F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjJZOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJZOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:59 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE4D4B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49618e09f16so457025e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698331730; x=1698936530; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=XIsBta2gqorH+eW1Tl5gX/6yDCS3r+s/cKlITjSWU+mnuMN0AyOiNMu6UJs4jgBgsZ
         E2SjWe0+5yAusnUReHe6sqUBR21Sc2Igl9v/yZm328P6J/T/+DTh/p/TiT6rXJNUEeUu
         wdLUF572YEKcVH1pI2MPpa8kIHUPdPcssA7p4DFdXE8fYUWMlHm9vgvYfkoztI/OfkQM
         xlI3WZSeqDepVZpfg9oda6eYM2mCGXUMoOmF1hTRyxVISY4i6bCIXL0U/kqb1NB7OrDN
         lE+NLOti8OCm4TSm5iEz2nOKq++oktT2Vb6t3E9nQrcbTLQuHmFsMKK254D93ENsedLH
         UnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331730; x=1698936530;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lzK1pFiQoRniXEGjF6tOObNRoBOW1hYjV90v0xvTKY=;
        b=Oa+C8ek53oR9cL1e2HYja2aQSl45P/Pnr0HSPDJ1ysLdeAfzRZFpwF/0QnosRXbdPv
         keeiQ6gnUPrHWB+6WJSP1apXcQClvcC34wF/woWfe2PcUAfp/1ZY53R7sB6I0wZnqaD3
         KKUc6f7k617vaA3SjYM3UmAcXxEgLcF94avTT0nuHgfTAmsz4vtzEmP14k4U5acbpGHI
         GAZSFTIxQ73I6Myv+lMVbqknRvzI9HH1/VUEqjHXJ4Mb+HJjhyO6+JCQ6OfWH5bvfByV
         tfIvgmI2iAm9RiYsXgMhwc9tBpJkjk92DVJIncYjxva9SJIU+G//Y6LpIP46tE3FSxsb
         V4HA==
X-Gm-Message-State: AOJu0YzOMTBL6Bpt5vh+cMT5UDxxBMLqpSY/omVsLIc+6WkWDtwIWFd0
        k8ZzXOv1s5rCCWqZAbtJuGif
X-Google-Smtp-Source: AGHT+IFOXcomS2z3Xzc1G+uf0v//E62w4tPep5wRMeQeBOXCc+hIrVPCulRaJjMdlYiUzKHt5WCX0g==
X-Received: by 2002:a67:e050:0:b0:457:e32d:1732 with SMTP id n16-20020a67e050000000b00457e32d1732mr15674294vsl.4.1698331730343;
        Thu, 26 Oct 2023 07:48:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cf60d000000b0064f4ac061b0sm5252286qvm.12.2023.10.26.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:48:49 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:48:49 -0400
Message-ID: <dd0f6611c7b46f3cecee2b84681c45b1.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT  calculation
References: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_COUNT
> calculation, used to limit how many LSMs can invoke security_add_hooks().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 1 -
>  1 file changed, 1 deletion(-)

Merged into lsm/dev-staging, thanks!

--
paul-moore.com
