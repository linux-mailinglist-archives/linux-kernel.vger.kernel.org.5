Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE567A5062
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjIRRES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIRREC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:04:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21197CE7;
        Mon, 18 Sep 2023 10:03:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7927952ca67so161267039f.2;
        Mon, 18 Sep 2023 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695056607; x=1695661407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAN6eFd4fB8Jue9t+rReqiCy+eBs2TmxKe/oinfuoLE=;
        b=OIzQcl97ZRLQ+WGRsaq65pyKTVZo6eClWd58KvfDPmxx6VjTkuHQoHEFBUUNXtDAuM
         bmzqfUWOsVOrM0FeUTx08ZSyD8KtYM4iAP7mH21K5qcGVEZb4f5gfP2cFlKWZrt7QO7c
         vo6+Dg6Xq4MtgueNP8fsO5rYRtmyg6ABFDBoY2yAsVDZSkst8c0dV2mN1sx3qtxFFuTQ
         e2DT3yrzzfDOsF+IF8VZtN/SlVRmlSfrX4frPtxnU2rWAALdlInEPFBXlpV+RX+Ps/3O
         fLfIqAMktWGIJgClt8v/zO4WpHf8aqrM63ivNjPXQMRoKW6Ydiuc8/9W3G7kxz0fSMzW
         Z+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056607; x=1695661407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAN6eFd4fB8Jue9t+rReqiCy+eBs2TmxKe/oinfuoLE=;
        b=dx9mWWl3u1CQ2y8md6NcZw9gOWdf5/ny7hThuquLQe6D2f2x2QAM+k84+5cVhGNQr4
         0f9ISDxR7R9K2UB0eL2Q0dlN5ynmah8aWiTJKgwEnAZmIX75w1r2UKI5FTs061+OrGIg
         wYh/JsUDHtojs3MPpBAuaMxBqW9zDed+YWksy3FuPpbqLyRc7Xmd/m0UA4XnOrwT1x10
         x9xKhwBAVOpKNQ3mq2ze53LT7ThdmLVHwnc9P0ApY1UVGEWx75jIhviMhHLGoLrrZDRG
         DzYnRBypfpFXsvyU3P/gdMREMoClEfhLbXx3FDA7OdmUoxEAikdvpfwOadBJwCSQoabM
         4SBw==
X-Gm-Message-State: AOJu0YytRH8EAB3SthYak3baUgt9JMu4xC2r/dRjTSXNGQXdTnpzkYFj
        r1pXfO1ScylLmoASIj2cEU6gCfVHhRc=
X-Google-Smtp-Source: AGHT+IGK7meVu2qpFrRpwKHUVrO55cSDbF7VstRtUdvHnRD8iWEdQS7od9KpvMDyXqsrVafFxATjhA==
X-Received: by 2002:a6b:5c18:0:b0:795:16b8:85fc with SMTP id z24-20020a6b5c18000000b0079516b885fcmr10619896ioh.0.1695056606987;
        Mon, 18 Sep 2023 10:03:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gw23-20020a0566381ef700b00439e20a2c59sm672740jab.144.2023.09.18.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:03:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 10:03:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
Message-ID: <79a88da2-70cc-4d4d-b322-c44135365969@roeck-us.net>
References: <20230917191113.831992765@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 09:07:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

ChromeOS build tests complain:

fs/ksmbd/smb2pdu.c:6256:6: error: variable 'fp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (work->next_smb2_rcv_hdr_off) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ksmbd/smb2pdu.c:6367:21: note: uninitialized use occurs here
        ksmbd_fd_put(work, fp);

That is caused by

> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: no response from compound read
> 

The compiler suggests to initialize fp with NULL. That _might_ be
a feasible solution.

Guenter
