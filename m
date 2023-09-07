Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAB796F21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjIGDAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjIGDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:00:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4678CF2;
        Wed,  6 Sep 2023 20:00:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26d54d3d984so355939a91.1;
        Wed, 06 Sep 2023 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694055643; x=1694660443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUJxYvsG6Jlv8dEsebbaMuaTa9UkneN33pcGX5BWag4=;
        b=LwVwqT6U5q4BpiGxUmIs8hJdbgmHHSBr2i5mYtuTCS3nn/95Gvse3xqdnkKHTRHr/p
         ey2svs/XShnEE75r9g8YJo/WODPd0abHH3YZi3mFxoxJZ0MvI+iS24jReGee87TkNqeN
         pLsQDX8n/meDNBxw64vLW6QsalpxyyzaSf4/0KTEDpa8zMX0U9QSaZ19g3n0qqEI20XH
         PiSfREA81a2SnBkgrZiFH5E6gVTP+N13waRFv4yf0qKJV0dLhLwYA549gblAwtj75IkD
         Mizj9toCfc+l6TrXbk6ElGTAqByV0/LBPGZP44zs8XJxZMtR+MhKQMLL3WzDP3QreftY
         FSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694055643; x=1694660443;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUJxYvsG6Jlv8dEsebbaMuaTa9UkneN33pcGX5BWag4=;
        b=VtkN9hP2lwf9Stxexpn4ZoaEE8rpp7Kht9bX4ZWkt0U4NIAhfAfGt+vxzCo32T5z40
         V756HCaJDUSUZz7GrVqhXpEA8lEm+9XpgYheeDZDCsL5rLJH6ZD24Dd+PORR1+JtGajj
         FdCOaa2Wunp0DFcMlYl/39uHeMgqm3w+jh+8ZeGQHcIYMAfuqn96MvrkN8p084yF/LHI
         PR7FLf7ClfFvqMV1qpETfJm6phuZ4l3bz05gRRKskmBfQMN+SP+eEeFPVU8aCPqexKvM
         vDQou4tJPjEMBSIvL761hwNhw6JB8V9MPnFu57AK0hZA7fndctesXuyWpOsaBHtXjuco
         KNIg==
X-Gm-Message-State: AOJu0YyJ+HCh74zjapV5LP0VT1niM+LPulbj4L/oDzxqBVieYWNg+RNK
        MxrfC1E7PFhcFFW8B5f25C4=
X-Google-Smtp-Source: AGHT+IEDUeXD4TmKX+R8Cn3mDEMqJk5NFUiPCGK8OjFzpRIrQpx/DWsOyiGYdM6HRn57W0/y7oLbzQ==
X-Received: by 2002:a17:90a:7545:b0:26d:5ec:12e8 with SMTP id q63-20020a17090a754500b0026d05ec12e8mr13732307pjk.3.1694055643151;
        Wed, 06 Sep 2023 20:00:43 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a001a00b0026b12768e46sm500284pja.42.2023.09.06.20.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 20:00:42 -0700 (PDT)
Message-ID: <e33882a1-f0e7-4bb1-04eb-332cadc8e2f6@gmail.com>
Date:   Thu, 7 Sep 2023 12:00:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230907111112.02c64e37@canb.auug.org.au>
Subject: Re: linux-next: Tree for Sep 7
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230907111112.02c64e37@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 11:12:01 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* include material destined for v6.7 in your linux-next
> included branches until *after* v6.6-rc1 has been released.  Also,
> do *not* rebase your linu-next included branches onto v6.5.
> 
> Changes since 20230906:
> 
> Non-merge commits (relative to Linus' tree): 1537
>  1783 files changed, 276430 insertions(+), 25266 deletions(-)
>
> ----------------------------------------------------------------------------
[...]

Stephen, I have noticed quite a few redundant documentation files
reappeared in today's linux-next.  I didn't check linux-next earlier
this week.

Redundant dirs:

    Documentation/loongarch/
    Documentation/mips/
    Documentation/s390/
    Documentation/translations/zh_CN/loongarch/
    Documentation/translations/zh_CN/mips/

Bisection blames merge commit be2bf9967daa ("Merge branch 'for-next'
of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git").

I suspect the conflict in Documentation/bpf/linux-notes.rst caused
those files once moved to arch/ in upstream to be picked up again
during "git merge" ...

Best Regards,

    Akira
