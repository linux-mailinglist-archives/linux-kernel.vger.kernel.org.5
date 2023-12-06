Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4B8077DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378858AbjLFSoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378886AbjLFSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:44:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BBD5A;
        Wed,  6 Dec 2023 10:45:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfabcbda7bso9259745ad.0;
        Wed, 06 Dec 2023 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888299; x=1702493099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+/98j/xqe2VNXzxExNyuXe8kMEXJoLbPHQEvWYwrPg=;
        b=AgYilJxELz75YOCYWap0cDdOe9HUIV6lXTHSNELY9VKbdq75JsRu0gonNE85KGkpaT
         dx+tYRCEEqd5kFu1bXGiDzPyUNl1yylqTJVcGeFEK/EG+TOg0av4EaYpptQI6jdaH+B8
         gsGTHylTVuOm+rcy2cWkipMfTaCGNr0YFhBz/iqzM1BXI3irVd5Ms4vAkIyawHsHtN5x
         7sBCZTcTHHw4HQ48xc9MrH9+jI7LQdRxLUV/gcZxN4g+d8/UyKSQx40R+Ao6HcuoAF0w
         MYv5UAWcX2nJMoCd8tzQ31AeOjiGYrpJGA9id/kJ78m0hNRnc42apXbTLkwAgpEVyPHT
         OwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888299; x=1702493099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+/98j/xqe2VNXzxExNyuXe8kMEXJoLbPHQEvWYwrPg=;
        b=fCLjBf/4s2eI53jsfvFcxYBeULz8tsG3PuOmtNGdV1a5bG/goBslZHID8rZ6cF95kj
         lrbfMax3WGku3Rw5sUCogGHqjlxNgOJnVAVvTPnvLzZ44dr34N5B+f5sEGHWXO5EBCyr
         iJ4Rx1k5e01KY05+1fNawVU2Xjnvk860b6xsiUi5VRCkpLm7jQSg53cBjjASMdIIXbuV
         peUCMEtp5Q8Hvlc4nl4uG1mRGrlyCscpMxwSAJPGXwB6PcHM8VD3ZeS4wIYKwzffBolh
         XWhb7ovpZ+fIJQr04va4Q5NeHZ/fsJs/DHPzl8a6znjxaOBuH9z1AkHM5jO8MDOskSZ6
         x9Rw==
X-Gm-Message-State: AOJu0Yz/IgaZNpSrpV2yG5THeohDftAwN4AlMexC4hsNGl/f1DCLsD1x
        2IWCkHgY3wtbAfTX9HfvBVE=
X-Google-Smtp-Source: AGHT+IFbfCrstIdUA4m1TuN4ZqxGaAd1VlYNtUqPm4jg7M0XPKC9yVJuEBtBHvWQ3wVPiv6eHLzAvQ==
X-Received: by 2002:a17:902:d487:b0:1d0:b5aa:2ff6 with SMTP id c7-20020a170902d48700b001d0b5aa2ff6mr4917265plg.39.1701888299532;
        Wed, 06 Dec 2023 10:44:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001a9b29b6759sm145074plh.183.2023.12.06.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:44:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Dec 2023 10:44:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
Message-ID: <b118cdc1-3cb0-4a27-8b74-6cb27e45b689@roeck-us.net>
References: <20231205183248.388576393@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:22:38AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 537 pass: 537 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
