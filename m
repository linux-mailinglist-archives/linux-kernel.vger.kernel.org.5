Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAC80CE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbjLKO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjLKO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:28:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ACFC4;
        Mon, 11 Dec 2023 06:28:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d319a7a35bso9188695ad.1;
        Mon, 11 Dec 2023 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304887; x=1702909687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udIPnt0xePI7lK0UIRTRKSi5bEo4mXag/NkKLOaAELc=;
        b=Ilvi0OCcD6XuFd+zpXmeaynbC2Kw0rLnkcu5Q8Qymy0AqrbTND96OwyRZovYsjuDfc
         8umuQgm3JZ2eYWPtkd9MID33OymdZ7SzIwIFT+DHIdf8mHNfZPGE5y7wfTCDzr2zsBrd
         fug8B0/Uz7TU3HvRsEZPhQURiEvCB84e+HxU/BaY7nMUX9jd4ITd9ttDU9/mRDmL2WFp
         cyoJhT2M7bKduYNhUCq4HuPigTmfDV899T9mOhfgmnU7RGV4iTQsFdjkQOdYhI3rxWJ1
         75kHnfUdqeC76LBCgaucmqpKxaCxFwYGVNlZE4P6sDhuXTgxfvnz/wqfNG10jsFomg7i
         1lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304887; x=1702909687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udIPnt0xePI7lK0UIRTRKSi5bEo4mXag/NkKLOaAELc=;
        b=otjZ80S1+x9RuMexxG1JMYJlRyIzBsX9sCMXWROcA4h3olqzokogePprnwYVXHsjyc
         lwS3aIKsagaVSD42JQjwwpMFPbo/fiN0d3zUniBBM3UQqh3eYH+xvm5GDJPecQPxp7Av
         sT0n0hS1lBEV/Y1EdtbMW6n8qbGv3NYEYSLzpJrPaQC15P/UYVXIpyYiRsfB9aEOvnPB
         40jxfG8cSXaJD/SQxBUtXfym/pwr6ZUwK28HbPWdzS1sYSGd6fwHHbC01BGIT/MiYMkR
         Nf0Rm26fuaB+uA6ASDuPog5ryee5EERHsQeTtD24yg0fJULfEn5WRUrd0JwN5ddMUAha
         l/7w==
X-Gm-Message-State: AOJu0Yy1fAnR/rsZbr/t0ww6BG9zOiUWi8K5s5NXO0mPHea4F6NiNMuY
        odjNcaYerPxXsMtCDD+AYM7dpH5ZCcs=
X-Google-Smtp-Source: AGHT+IG2C+mllSMSng3qYxzxBO68sbVLanPcjjHO8x6CRcjcGaQL1pMMXuIJ5TvaiqUvMwiE7XsdEw==
X-Received: by 2002:a17:902:e9cd:b0:1d0:8fad:f187 with SMTP id 13-20020a170902e9cd00b001d08fadf187mr3777154plk.48.1702304886650;
        Mon, 11 Dec 2023 06:28:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001c9d011581dsm6677475pls.164.2023.12.11.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:28:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:28:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Gloor <code@stefan-gloor.ch>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: sht3x: add sts3x support
Message-ID: <13a0b693-f6f2-4c39-892a-a2802b5084b1@roeck-us.net>
References: <20231204165004.8491-1-code@stefan-gloor.ch>
 <20231204165004.8491-2-code@stefan-gloor.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204165004.8491-2-code@stefan-gloor.ch>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:50:03PM +0100, Stefan Gloor wrote:
> Add information regarding the existing support for sts3x series and
> update the datasheet links.
> 
> Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>

Applied.

Thanks,
Guenter
