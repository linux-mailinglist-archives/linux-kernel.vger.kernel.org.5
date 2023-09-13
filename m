Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10879E38F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbjIMJZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjIMJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:25:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A21999;
        Wed, 13 Sep 2023 02:25:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fb70fca9fso2843405b3a.2;
        Wed, 13 Sep 2023 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694597115; x=1695201915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpFYAXnOqxjLWxlwZ45c7Msf6OlbS0bhBMJrCMsl3zg=;
        b=nSnCf0cK4xpn5q4uEWbi4jgNyj0YzEsrtBBZ271rYq2sgh5We1k0YxkCtQ4fazBZos
         ePABUdjDWp3xK7NGi+9pyFeYQ+QTnstMkVdat7uZJ5NbLR9n8dbjmW8xRKh/+ntPtm/t
         oUGiR4lOAqjyCbO8F7DNfmFHHourggWUIRInKRKcg5U2dqbbjcVD+ZqM93L6n0T8nLsO
         XMX8CsWd79cvTgVmZ7TgOcknUcS0XNVwiJ7feFCfM3xcVou08AeFHBLCddNMP+i935Bc
         yKIfxiEyRC8B60TNfKYiBx4wnKx+/K3gLTEHH2+Q7etVfYAqgw/G544/zGAdvKpsDqwO
         JXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597115; x=1695201915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpFYAXnOqxjLWxlwZ45c7Msf6OlbS0bhBMJrCMsl3zg=;
        b=AIAkg9YnxQsQyiVbRqg5n1xUNLOyholxgx3Vu+bHGBI9x+wTDYBDKenAOFvotQJ90E
         q34z4mzNhzLFtBFErH5UcizFWYzfXw+xv6MUoLPqzEruIez3z24qfkhmW8uBPfVuUsrI
         Ic/yC2lctMPuDp9R6Wk0bwq61Qt8WTN/9oGEzmzja0XYalSglKYQ/sOcB+Az2gj7sVpi
         fos8mUV+SRAe0qQU0nH7bktWS1CSAo44sPTvLXKvSunJkU6xAG4OQT3/Bg8Vq1xLxldA
         wEbbVS5qx8lADAwmvchVdn9TQwnc7dpENfJIgR2yAz1NeB/n/vm1SMbnaw2zy6Gx6WRG
         vVVg==
X-Gm-Message-State: AOJu0Yxf/9b3naYXtLDUcMuj/0suPI5XXpl4TQQ0+GUKlt1Q+W2d3eQ0
        SYGJeyE5PeKBdTZM1oZ3SXI=
X-Google-Smtp-Source: AGHT+IG/3WIzQMbIKyGZtuuCHIWrLbl2lrCKitCBZEZyOjDkgyQfkCiMeKwYbJrLvyEtH8At6O8gvQ==
X-Received: by 2002:a05:6a20:8f1f:b0:13f:c40c:379 with SMTP id b31-20020a056a208f1f00b0013fc40c0379mr2117577pzk.13.1694597115404;
        Wed, 13 Sep 2023 02:25:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b8b26fa6c1sm9914334pli.115.2023.09.13.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:25:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9D86780666AA; Wed, 13 Sep 2023 16:25:11 +0700 (WIB)
Date:   Wed, 13 Sep 2023 16:25:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [REBASE PATCH v5 01/17] docs: qcom: Add qualcomm minidump guide
Message-ID: <ZQF_9-nX47QUCycO@debian.me>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-2-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1694429639-21484-2-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:23:43PM +0530, Mukesh Ojha wrote:
> +Qualcomm APSS Minidump kernel driver concept
> +--------------------------------------------
> +::
> +
> <snipped>...
> +Dump collection
> +---------------
> +
> +	+-----------+
> +	|           |
> +	|           |         +------+
> +	|           |         |      |
> +	|           |         +--+---+ Product(Qualcomm SoC)
> +	+-----------+             |
> +	|+++++++++++|<------------+
> +	|+++++++++++|    usb cable
> +	+-----------+
> +            x86_64 PC
> +

Sphinx reports htmldocs warnings:

/home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:100: WARNING: Literal block expected; none found.
/home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:243: WARNING: Unexpected indentation.
/home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:234: WARNING: Malformed table.

+-----------+
|           |
|           |         +------+
|           |         |      |
|           |         +--+---+ Product(Qualcomm SoC)
+-----------+             |
|+++++++++++|<------------+
|+++++++++++|    usb cable
+-----------+
/home/bagas/repo/linux-kernel/Documentation/admin-guide/qcom_minidump.rst:243: WARNING: Blank line required after table.

I have to apply the fixup:

---- >8 ----
diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/admin-guide/qcom_minidump.rst
index 20202da8ca40b9..5709a3853ae7ea 100644
--- a/Documentation/admin-guide/qcom_minidump.rst
+++ b/Documentation/admin-guide/qcom_minidump.rst
@@ -95,7 +95,6 @@ could be anywhere scattered in the DDR.
 
 Qualcomm APSS Minidump kernel driver concept
 --------------------------------------------
-::
 
 Qualcomm APSS minidump kernel driver adds the capability to add Linux
 region to be dumped as part of RAM dump collection. At the moment,
@@ -231,6 +230,8 @@ respective dump as per set download mode.
 Dump collection
 ---------------
 
+::
+
 	+-----------+
 	|           |
 	|           |         +------+

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
