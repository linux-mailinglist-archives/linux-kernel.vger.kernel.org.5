Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155C7A8ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjITRl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjITRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:41:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3885B9;
        Wed, 20 Sep 2023 10:41:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-773bd514996so905485a.1;
        Wed, 20 Sep 2023 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695231680; x=1695836480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llu5nHgEQacDL2hr7yeW6ndQcmaqNUQJseQZznlx1ws=;
        b=WrFA1MqIgo7M3z2+30rb7Uj6VoNIbDxb+V8YmDOwaXfVAYxstS3ILnkxBJsv2s/X3I
         2zxmasNerUKEYoqi267lEQWJwd/OcAIj7DiuOSr1xFT6fCU+rUqRmCh3LpVHEqx9qcG/
         eAmPANbqxM6JRYNEqxIwUa9PshzDVNnblk8UrHJ1aI0DUVHRO2wgkB1vnmEM+SaOPk4E
         eSGfjSC/R52A3ygl1tHRsYHFHYk1uC/TsNFPAgd59jGf8VSCXA/nAfYr2vt8uiI/ADfD
         JE3bMfL05TxM76lHL6sW5npGu7QF5JDVuZ1fcLbEl0df4b4QVUQDw7Hr3a0ZV+6r3r1W
         XzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695231680; x=1695836480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llu5nHgEQacDL2hr7yeW6ndQcmaqNUQJseQZznlx1ws=;
        b=GWLsKm5Yp1dxXnDeXlFp6gSTRXl3B2cDKpV4JufmSMp2uQHTeMdYB+6RQfwbrdqTUu
         uGnDEpoRMfjknk3qkdlA1Dm2g+Fm49HVli5Cl5aoVVGVvaRVH+o/XKGHvMKLgKmqvCGm
         DPU2qpRP5CarBT69+FGCq+xF2GgYv1Ye3SJ4UTDwo8y8pYY171rNLU6V2xK/8LMoFChz
         QMcAAbP/sWwmHDcFaSvRyD+7LQ2I43vVBRjv4L5IznEZCGrWFcBwpN+meH4xwum6r2eF
         rP6yAIWgHbCqEeVqnTAdVLubtXSfdRewt5G35S2Brh3967nSSCBIUsrOjV4KwHtYYovd
         J25w==
X-Gm-Message-State: AOJu0YzqRJbm5daSR7ITn9fL1c3aIJcCumXWhV8x9+GSkwQtrCWwkSkD
        K5J19eOkQ4bjjNGrzYEsgog=
X-Google-Smtp-Source: AGHT+IEC0w9SyUCFOAOQxCTeactjZLUpNr9UDGDTOq+PLXoa/k/pnmYH3DgUWS1kNhRIC0uSrkf9wg==
X-Received: by 2002:a05:620a:1920:b0:76d:b5ce:8f79 with SMTP id bj32-20020a05620a192000b0076db5ce8f79mr3088172qkb.34.1695231679917;
        Wed, 20 Sep 2023 10:41:19 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g5-20020a05620a108500b0076ef3e6e6a4sm4962053qkk.42.2023.09.20.10.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:41:19 -0700 (PDT)
Message-ID: <dbff79f7-8fb2-7473-8a11-57810a25da37@gmail.com>
Date:   Wed, 20 Sep 2023 10:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is
 absent
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, kuba@kernel.org
Cc:     andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, l00g33k@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
References: <20230920173508.63449-1-festevam@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920173508.63449-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/20/23 10:35, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done
> before HW reset") the following error is seen on a imx8mn board with
> a 88E6320 switch:
> 
> mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done
> 
> This board does not have an EEPROM attached to the switch though.
> 
> This problem is well explained by Andrew Lunn:
> 
> "If there is an EEPROM, and the EEPROM contains a lot of data, it could
> be that when we perform a hardware reset towards the end of probe, it
> interrupts an I2C bus transaction, leaving the I2C bus in a bad state,
> and future reads of the EEPROM do not work.
> 
> The work around for this was to poll the EEInt status and wait for it
> to go true before performing the hardware reset.
> 
> However, we have discovered that for some boards which do not have an
> EEPROM, EEInt never indicates complete. As a result,
> mv88e6xxx_g1_wait_eeprom_done() spins for a second and then prints a
> warning.
> 
> We probably need a different solution than calling
> mv88e6xxx_g1_wait_eeprom_done(). The datasheet for 6352 documents the
> EEPROM Command register:
> 
> bit 15 is:
> 
>    EEPROM Unit Busy. This bit must be set to a one to start an EEPROM
>    operation (see EEOp below). Only one EEPROM operation can be
>    executing at one time so this bit must be zero before setting it to
>    a one.  When the requested EEPROM operation completes this bit will
>    automatically be cleared to a zero. The transition of this bit from
>    a one to a zero can be used to generate an interrupt (the EEInt in
>    Global 1, offset 0x00).
> 
> and more interesting is bit 11:
> 
>    Register Loader Running. This bit is set to one whenever the
>    register loader is busy executing instructions contained in the
>    EEPROM."
> 
> Change to calling mv88e6xxx_g1_wait_eeprom_done() to fix the timeout
> error when the EEPROM chip is not present.
>    
> Fixes: 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

