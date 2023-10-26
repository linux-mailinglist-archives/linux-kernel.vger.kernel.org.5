Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35A57D893A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjJZTyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:54:00 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE98B9;
        Thu, 26 Oct 2023 12:53:57 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2800783bb19so305049a91.3;
        Thu, 26 Oct 2023 12:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350036; x=1698954836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2+XMK+lP/KIwl2728AI318eqcu1akpLvbSjPBWC6r8=;
        b=xPG6Gh+pWfiR3lk1vpgMPYGase25uMrERseuK/smbLGQ4VuXDZA4K+Z5TsIfVcMJPZ
         61rlO+G0VhJ6JN8ZlPr8PYAF3YxNxjfLP/4ipt/vi4TODJcdaRIP8JniTqGEPO0j9dng
         UA9sbs8ya1dIze/ujfhRpRyn0lu3HgviAPx0yz9qMVtfaaoCErUKYxgGG0J+g/q7WITG
         z+zUE/e9akNaJvyzCuEKW+m07eIFakJS7dhm0ZTQshaCHnQxf3CHuW1v9kEJr8tkaPSz
         BJksTe3bZ84pk5K0jEYnVX6TGR+bg3DFlz0ssNl0AnRUPQnuJURMDIx87NKj3w3LPHRf
         +YOQ==
X-Gm-Message-State: AOJu0Yw6PtsJLcPNabJBcVGu1zNb62qa/l+hEgEGF/F1NEJ4qnvgoDN9
        ttnbI4W+DYqf+ScWguLkclY=
X-Google-Smtp-Source: AGHT+IFEOHhPKo+/PUHeDAlsxPLYHm8mC6MetCeHzmMUhrWfpV4OQIr1tq/amQYucRNYrtagSfxt/g==
X-Received: by 2002:a17:90b:a08:b0:27d:549b:3e6f with SMTP id gg8-20020a17090b0a0800b0027d549b3e6fmr533620pjb.46.1698350036542;
        Thu, 26 Oct 2023 12:53:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:de84:df0e:e310:eaf1? ([2620:15c:211:201:de84:df0e:e310:eaf1])
        by smtp.gmail.com with ESMTPSA id i24-20020a17090ad35800b0027782f611d1sm1988747pjx.36.2023.10.26.12.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:53:56 -0700 (PDT)
Message-ID: <78ad6b62-e197-417c-8f68-332d25c48879@acm.org>
Date:   Thu, 26 Oct 2023 12:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] scsi: ufs: ufs-sysfs: Expose UFS power info
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 22:59, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bounch of power saving
> features and various combinations for backward compatiblity.

Since this patch introduces new sysfs attributes, it should include an
update for Documentation/ABI/testing/sysfs-driver-ufs.

Bart.
