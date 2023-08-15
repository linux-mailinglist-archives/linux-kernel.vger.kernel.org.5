Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D351077D5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbjHOWJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbjHOWJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:09:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D321FEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:09:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7658430eb5dso519795985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137360; x=1692742160;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+y8qETZYNAegIOhFR4VJ0g7JbCPf/QOcti2iqgt86Y=;
        b=U9Srv10FGBxw3+U/yoCZTkKg7qUB6Wd/5rVFj++n6I3KAcE54o2N/rqoPRn1picQwz
         +pbFzaC4/3tYJZoC8usC0uRgxX3X4QDhsdkBQcRwdDP8A6i41f9xnzWwhOahuDuZskqZ
         fEQ3fidLQkfF8WpVNoAwaKK8hM/5ADbEIGR5RC4is7Uwa//Xhv4RlYHuAexoTbbV0KFu
         Dfg6xyUymxBQIeCpBxuQqjQN7M5w5LDFyh2EMsHhF2uWa3LnfG2GWmZ/mWDbBOXC6jn9
         xTC+5GgTXTahh2Q9E9yN5g/My7qXKDlHUV+niRbXFhtsvQwHXvMi5DTLRuHjaJU7IqA7
         49bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137360; x=1692742160;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+y8qETZYNAegIOhFR4VJ0g7JbCPf/QOcti2iqgt86Y=;
        b=EtMeCoLTrMOogaw0VIU96wer1E/APUuom3Gi2t30gLBTwJqunsQq4aRfm/UAA5nFzf
         yS/g1R2km8TRr/kNDKT5ScF44uSvYi4EsZPxHnEfKkQ6z2xEFEY3h6EDzPQNEu+kVaCX
         4tQ1b2j2tivFeZkt0kRweD4AujNtZQNnF+B8UUioRceAxT/FocCXPrbW9RmREN5dvYYT
         gTJGwS9Loxs3v6aHmvTV8WAYBhKw60qJeBbLWIxMA5NApcpWdC/uVlkPYCKtU0VjY2o4
         TesIO+C574tJFQ8j8qbUEvsujZkoazNd3GN9mhYsH5BY5F3h8nxJPnQFgWFD8JMmpkN4
         vQcQ==
X-Gm-Message-State: AOJu0YxVKVVBDjqpXpmUJjp8X7B5mao/nkFruxqHZs8URt6PS5KNrmzR
        oM9qsMniRFRFV7ca7hmDDj8QAoQ7TChHoVZrncbP
X-Google-Smtp-Source: AGHT+IEoxf2tOUQFGE1k20XiwUYizctfQkxWty9Jz+mUFWEiy3ZPDKtu4qfbZdOFt39QNXAkQpfg5w==
X-Received: by 2002:a0c:e0d1:0:b0:641:8c0f:1a3a with SMTP id x17-20020a0ce0d1000000b006418c0f1a3amr13871qvk.53.1692137360168;
        Tue, 15 Aug 2023 15:09:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r4-20020a0ccc04000000b00631f02c2279sm152277qvk.90.2023.08.15.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:09:19 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:09:19 -0400
Message-ID: <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: Add space before parenthesis and around '=',  "==" and '<'
References: <20230815204553.52261-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204553.52261-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> Fixes following checkpatch.pl issue:
> ERROR: space required before the open parenthesis '('
> ERROR: spaces required around that '='
> ERROR: spaces required around that '<'
> ERROR: spaces required around that '=='
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/acct.c        |  2 +-
>  kernel/auditfilter.c | 16 ++++++++--------
>  kernel/auditsc.c     |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

I changed the subject line to "audit: add space before parenthesis and
around '=', "==", and '<'" as the "audit:" prefix is more appropriate
and I'm a believer of the Oxford Comma.  Otherwise it looks fine and I
just merged it into audit/next, thanks.

--
paul-moore.com
