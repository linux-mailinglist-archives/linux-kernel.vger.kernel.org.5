Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB37642C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjG0ABs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjG0ABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:01:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB821E75;
        Wed, 26 Jul 2023 17:01:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbbbb77b38so2304775ad.3;
        Wed, 26 Jul 2023 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416103; x=1691020903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w33LNLoiwSw2VlILl6AfG1BwyassOteYXSp29cv5Yg=;
        b=RRqvq4CYxbc5JdrX98mwS6dZteytxfMJ+Tg5OWaQzsqfoVNk+Z+n86iT0IwR3be0Q/
         IHNyRN7Dwramj5xpizbbLCQWdvywqOx5yDmOdKHh8mYsfggrKNk0g06navLIzQI/XKMr
         tMWPfQK2NLJJTClPpi3CfeeI1AQ0cJTgF3KlrquyvHKj3l+VZDNRn0O81ODW6251+ODL
         ou8PztIILiWnS8mEaQ+GCCl/Cx9YmqPslZ/Qmmwj7TZiWVqttQo/f7cPF85rsGaklKsE
         fZvWXxG2lwLzGDl8lNf/nbvnjdxwZZdgu9nzODUH/2wQFbUHYzsuqtbGB3qUxvBEcPKZ
         Yq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416103; x=1691020903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w33LNLoiwSw2VlILl6AfG1BwyassOteYXSp29cv5Yg=;
        b=C6gTjw66Pc1NOESQNMSabG/WGLmt02hqoAteC5LrP8HFRNmWKEn6mnEKJ7Mik3ogpl
         Zmn1KmM8M320zsNqQglFgYaVXCeRRv0Rzw8VQRX37suVLzkvbzl+D0L7h1P1ikw6tBIx
         VT0GgHyIoX0bQuB4g+HtIwm+n+CMaqCtoBFruVKWg5WXJ4QSp22YSbc8Or7bkA9pgk0B
         E3JjEe4NGIJtTWznPt5hbH3FECIGnOSWeZdmGicyBpUcKw+mVwCAqemPt6q6tk0pIvsS
         1XTDXpA0KUCnh+iLhF0FuU53U6qSfsHx7tMAeqdp/RTE8Zc10N58U05sq9byduD6y8SR
         AeJw==
X-Gm-Message-State: ABy/qLYaZNS+sfkPNTKpo+HeMGTqe91NVLmVS1lKpC3bYi1cdU+dCNDS
        Ep94v0sckpR5vtL+AnZ0dT0=
X-Google-Smtp-Source: APBJJlHKGEtb+lgid+Eu9Cxp6poX57XlYRGXskc7sT8BANTnPMC+9AVgMOLgMOy/R+RXsqAmDkeg2A==
X-Received: by 2002:a17:90b:3ecb:b0:263:eef:1465 with SMTP id rm11-20020a17090b3ecb00b002630eef1465mr2771509pjb.44.1690416103308;
        Wed, 26 Jul 2023 17:01:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14-20020a17090a020e00b0026358dfd2a3sm1894038pjc.24.2023.07.26.17.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:01:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 17:01:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/508] 5.10.188-rc2 review
Message-ID: <d82c1be3-7177-4567-a0ec-5e7e23631922@roeck-us.net>
References: <20230726045328.327600022@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726045328.327600022@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:54:16AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Jul 2023 04:52:02 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 487 pass: 487 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
