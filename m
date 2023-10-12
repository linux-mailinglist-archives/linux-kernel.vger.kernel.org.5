Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74D7C65AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbjJLGf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjJLGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:35:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB796B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:35:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226cc3e324so592090f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697092521; x=1697697321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=WBXSd3EKP3sUGRyIHh784yWZiUdoeJvSyYSpEYTlvzzHuBDdWC0DZlZyUzP8+fOCDl
         roPdLFAVKhb7c8M7hNZ9SL64twoP+M/BjbNVSWyrhJHualoM1g4Adk5LVb/OJX808zFj
         13/x7C5V48FauTB2TUx1xtoj+FjRQGs8Y9A+WWlnABzMUMaEexyxhuJAJqUUsZFtfgfJ
         S5sMn5XmdcT9h5KGp3NaDeHMYvjLy3es1gqOtrRsMd+Ol1WEhC+GeGZ7rye978aLK+Bn
         Wh2BSg453a2Ce0ImJqGMIsJOdzcKMNZnEnEoyfq+A3a8HKUqwqdVmqFpYywpMycqIZYS
         WQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092521; x=1697697321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQJ/cDndsjVH2agIvBOxH1c6r9a6N1viOd7ZKtxc98s=;
        b=LClkHESLYNP+AFwcuPh9+In+wSKlHYwvmP0F3bNhWuWRFin4lONlFrWZ416f3Td4aQ
         sZ14qG9sj1J7I31TPe7xsjqgL37V1aP+Bq0AfXeivxMMEYwXsJGEsUdrcC6Uv3ANzpnq
         j4ktosWvXJlrulil4c2OzA4dwJznW0CatpKSFZ5muFeS+PhLX7YY0yPDxVsjBsRNhD3C
         bHJAqxpNxfv7n01DyWWg6n3Zx8F+mTP2Nk2VTGsvHZdr1JJSJ8UM4O6y+BoysT80PaRO
         bJ1uWBGNV5Go1Suvr8quYKv3pUdxbS+cDGh+YzXHOOHdrxL/yVQK7bDWIq4QgzeW5FpV
         otUg==
X-Gm-Message-State: AOJu0Yw0ozNRIjE5D+XWLom5KNSdywMHZ2cKq/TX+sylMknZni12Jc5t
        2nmjV9Y7tzrYz3w+u3jCBKIRSf6w042lm0wMdlQ=
X-Google-Smtp-Source: AGHT+IGyIk4DWPD2t+N+AVlVanqjBQjctxVfCWWxlM2wMWm7zGXjiSQ9b0DLtWesEsgOMQL+O1Pglg==
X-Received: by 2002:adf:e892:0:b0:31f:a503:c05c with SMTP id d18-20020adfe892000000b0031fa503c05cmr21106870wrm.38.1697092521391;
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm4650965wra.30.2023.10.11.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:35:21 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:35:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, iommu@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: x86: drop reference to removed config
 AMD_IOMMU_V2
Message-ID: <b9f08b19-80e9-4908-89f1-8712bb3b59e8@kadam.mountain>
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
 <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:45:03AM +0530, Vasant Hegde wrote:
> 
> 
> On 10/12/2023 10:20 AM, Lukas Bulwahn wrote:
> > Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> > config AMD_IOMMU_V2.
> > 
> > Remove the reference to this config in the x86 architecture-specific
> > hardening config fragment as well.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Joerg, please pick this patch on top of the commit above. Thanks.
> > 
> >  arch/x86/configs/hardening.config | 1 -
> 
> Thanks for the fix Lukas. But I don't see this file in upstream linux tree. Am I
> missing something?
> 

It was added on Aug 24 in linux-next.

regards,
dan carpenter

