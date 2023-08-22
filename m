Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD92784A80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHVTd7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 15:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHVTd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:33:58 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF22BDB;
        Tue, 22 Aug 2023 12:33:56 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68a32506e90so749564b3a.1;
        Tue, 22 Aug 2023 12:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732836; x=1693337636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P245Qc2EmnHXZ3PZEYzACbTz6XE0iJ6nHBJZzKn10B8=;
        b=VW4WwZawrwHNjgcoasvo/bEj1ZPe7U5fgBYXy3lZYH0FlcN2IiQQ6ywhleiPLk7cwB
         aBPxeQNMeLhty3Yk5WY2SYLK+5K+wnUyMmejSby/q+qyw829IX5YfBQx236LWF2H9eFL
         n9Azftzwlj8qvFdRhVyPKe+KvueD8WOlFEKlyT/rIrxeEDUpuPxxLVxYjj1ogRTDub5M
         qj7am+ZNlkMUVnfhuGEns3CA7Q4QJlyEFNkhGd5ckiZGUSNfzkdkrIGM/kNQ8s53m7zd
         KVJnCFJ0GIHY4keNZqRwfol8qY6s65ODYW/vdc5+bHNPush1heeJlFZ56NtPwnf9YC7n
         OhuA==
X-Gm-Message-State: AOJu0Yz41OAdL0wtDGtMzelN6HDvucm3RmVkv/ukpSKC9wRpOYd/F/ZZ
        8eCzU5jGewzKUK3yWx2JPONtdqi9/JiXnlLkNpENAtQf
X-Google-Smtp-Source: AGHT+IFYWJ1k+zEoUaXtXvoLAtBvNRwPFkCPJ1DkbsNOqORVjYbRSpymGfG4mwnsAo98kKT7rZUWkq7QIrhhRpLFfCI=
X-Received: by 2002:a05:6a20:7f8b:b0:145:3bd9:1377 with SMTP id
 d11-20020a056a207f8b00b001453bd91377mr12909175pzj.5.1692732836300; Tue, 22
 Aug 2023 12:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121216.21816-1-yuehaibing@huawei.com>
In-Reply-To: <20230721121216.21816-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 21:33:43 +0200
Message-ID: <CAJZ5v0jY1WLWtLTk0yfTC43PaDa-V3GMisAksfHYzFFg-3HEZw@mail.gmail.com>
Subject: Re: [PATCH -next] PM-runtime: Remove unsued extern declaration pm_runtime_update_max_time_suspended()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rafael@kernel.org, paul@crapouillou.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 2:12 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> commit 76e267d822f2 ("PM / Runtime: Remove device fields related to suspend time, v2")
> left behind this.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/pm_runtime.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9a8151a2bdea..7c9b35448563 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -85,8 +85,6 @@ extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
>  extern void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
>  extern u64 pm_runtime_autosuspend_expiration(struct device *dev);
> -extern void pm_runtime_update_max_time_suspended(struct device *dev,
> -                                                s64 delta_ns);
>  extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
>  extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
> --

Applied (under a slightly edited subject) as 6.6 material, thanks!
