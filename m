Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320B57D70E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbjJYP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjJYP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:26:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530D1985
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:25:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a62d4788so9147618e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698247522; x=1698852322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tsa45sh4cqXtyQ0fX38sVaI+3vtTh68MnktVz8dXRb0=;
        b=Khg1/9Oul9iZ7OvI1dolfaj7S+OKMZ87/fvyhMIvhcrGWD2COcXoqH40HxQa8o5GX8
         lk3M6e2xzbB75VzTH9yfrj18dZMIUEhy5e07iyqXONg6/ktNXAHcjXQ3X17oZwBDAWoy
         zrtn9w+WbLZ2Z1cmPxkV4HQI/Hez3n2eKVqMN+8sM1y3hbanUfi3/QSQkJc48InelrmI
         UG9nqStyoSwQg/Kd1DGltuBduwl8lGLsl6Kd018HQto7k9m8S47DvnjtakTgWgfz+qJC
         +rS8IAfuu5qp25HSi944o21xFVYYrBZ0y98hdFzqY4kdbunmyohg7MKnzR8gSox0SMpL
         l7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247522; x=1698852322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsa45sh4cqXtyQ0fX38sVaI+3vtTh68MnktVz8dXRb0=;
        b=JEpRHLBYd9KUjDn/SX+3CZrfv6xJSTgrDraKo3LSCDTngkUODXc+NqHiRQfdAfsw18
         rcWy8kAzbFI1ITqvRNr+d4L0nken0fBH9UhD7vxQSfqzAyA7EzZPMa7YehJed0Q7CA8f
         izB5Fb38t5DmegVCTISDK9RsRBaH3Fl6olxcXbm5PG4K1jhYuhVaCEZUA1C8gGfS8Ngf
         lpeqLNTp7+om9SewvIBXvsyuUvDyaLqHyBrhI2HsrkpLQL2Q3s7QIdBVTPgjMrLeK2iU
         8KG0LkhI3fBsMUflWUvUOW0Ci/z8u57V48sBHb7CX0jsQitDzGy8SU3cT3lBVJ2GfrtK
         YWNw==
X-Gm-Message-State: AOJu0YwnDvFA4LyyB52BgwBlcOPHcy8TB73JU0sw4V55Kex+MGtXdFrG
        AzFnMeQwO2obvABHFlRRNkbbtjcWXDFaTg==
X-Google-Smtp-Source: AGHT+IEiBp9E2HtKgRFUjADpNprvPh7PSPSdlx6gbIxyVpoDz2R0r9mNytg/+FTSDQK6bObp6eOYmQ==
X-Received: by 2002:ac2:4186:0:b0:508:1851:d29f with SMTP id z6-20020ac24186000000b005081851d29fmr1642578lfh.11.1698247521905;
        Wed, 25 Oct 2023 08:25:21 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id n15-20020adfe78f000000b003197869bcd7sm12344076wrm.13.2023.10.25.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:25:21 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 4a32ea01;
        Wed, 25 Oct 2023 15:25:20 +0000 (UTC)
Date:   Wed, 25 Oct 2023 17:25:20 +0200
From:   David Lazar <dlazar@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PIC probing code from e179f6914152 failing
Message-ID: <ZTkzYA3w2p3L4SVA@localhost>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx>
 <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx>
 <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--- On Wed, 25 Oct 2023, Mario Limonciello wrote:
> David - can you see if the below helps your hardware?

The keyboard and mouse work fine with Thomas' patch.

I've uploaded the debug info to the bug:

https://bugzilla.kernel.org/attachment.cgi?id=305291&action=edit
