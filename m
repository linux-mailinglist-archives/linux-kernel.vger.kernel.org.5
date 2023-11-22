Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEFB7F4D94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjKVQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:57:23 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D60A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:57:19 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45dad6ece90so2034787137.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700672239; x=1701277039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZB27VWkiR1n6T0R6xoyF5FkoYqj1JSNRWgLWoOfmVc=;
        b=xb+zsQojYgXnjepsFOshWRSM1TtsjS/iEoXDF2MOkle6oELVk4oqv0gF1TgrzjsQeD
         UX/bQiucCWdRLIv/ZDwt/pcSGm4lAPB14SX31PqD8wf/i31BLl6Nxrt56WcRDAWKtUd6
         IkqBJANeCiB82rcd4huTEDxNVEjK9nGVomK4nUqXowT+cB5d/SMB9dK+hcv3yg0ISEN6
         pjCeWRhO9CjBsEn1j8Hv7SHC/AUibAjG1rAFZidzg4yAbzWrPwsIrtkvt3k9qWInvd9V
         tp0lJ1zxlRg5EL6U4aP2lPsBWathHgehuy+dtaYeFfu4m4opE73HuIUuE36LGjqhnF8y
         qVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700672239; x=1701277039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZB27VWkiR1n6T0R6xoyF5FkoYqj1JSNRWgLWoOfmVc=;
        b=Gl0bfyRLaMs/9rqyhXPeV8LI3h4PnOuO8fAvEkwM4pL6DWAcFcB+EmnO2BDNVdtfiJ
         3Ld5ToCMJA/zLyB3KISjiJhcJlXuwcZBQeAVnel+kcsBCB9B0FhKAxf5xoqacjejMs2U
         4m2X8jD5mmDwO2/XioZhlvO7pOvp530BhVLliDQdV/qsLsh1xGOxLqemzMgfGwMQrd9C
         XjAXhUp4QFtPGjntIbsqueT2HM5OMxM6omK0LcvZLPcd5aBFCmanImGqFXUjjUTuf3iu
         QC8yp6YiY+GnknsBEo+JYAa7srCNK2lxyap7S0mo78vvtJh100gcVXBwsryTC6lo5zK3
         lv5Q==
X-Gm-Message-State: AOJu0YxlZil0RZccfhsDlMEBFBmBNrqhngYX9lM0j+nZNZ97szxpRCZ3
        hJOZHvYc9rLZzMCuoLfKDOee3ukwj5cifH3gE76iUYf4kLbJd4DhWWc=
X-Google-Smtp-Source: AGHT+IHlP0thRJpP4ss6bt8AweGLOz+Xn6zK35geAVWg7incFTfb0O50sy2L4UTcUc6iNu8Y7EDoeeF6Irpfhg+mHrU=
X-Received: by 2002:a05:6102:4745:b0:462:913d:7c41 with SMTP id
 ej5-20020a056102474500b00462913d7c41mr2735425vsb.7.1700672238916; Wed, 22 Nov
 2023 08:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20231122155916.38037-1-brgl@bgdev.pl> <480fef02-09ed-9a32-d5bb-e7114381220c@axentia.se>
In-Reply-To: <480fef02-09ed-9a32-d5bb-e7114381220c@axentia.se>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 22 Nov 2023 17:57:07 +0100
Message-ID: <CAMRc=Mc_KAX0QWSoL9UEwwjFCD=fHv6ydceSYwaY91C=RkURxA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: use of_match_ptr()
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 17:41, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2023-11-22 at 16:59, Bartosz Golaszewski wrote:
> > -             .of_match_table = at24_of_match,
> > +             .of_match_table = of_match_ptr(at24_of_match),
>
> If you do that, you will need to also add #ifdef CONFIG_OF around the
> at24_of_match definition, of you'll trigger a warning about an unused
> const variable (for some configs). I think.
>
> Cheers,
> Peter

Nope, no warnings even with W=2. This is true for unused functions but
unused data structures are just silently removed.

Bart
