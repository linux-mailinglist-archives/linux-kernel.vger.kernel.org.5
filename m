Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81137B8233
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjJDOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjJDOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:24:54 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B7BD;
        Wed,  4 Oct 2023 07:24:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e12f41e496so1414413fac.3;
        Wed, 04 Oct 2023 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696429490; x=1697034290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVKBCcPpDCxr3rhiKMsHdrcSvEVmztxq1sjsldYXfrQ=;
        b=DitIJBY294iqw8zGSR5iwh/A/SWmvZUljGl/iMIdgjUed8f3feaFzjRVQQka7sbNaK
         r7p0GRbQAXV10tun+tTaXlJvum1xXNeSK5WWFZKR/cu2NLvnHeoPhRGfvq+1EhQdlpho
         oZUmLxo8fU1b0ufRYliEtEBmGpXRK0cuvLhhR/O/vQqo/jsOyL1vXIQaB8w9I+XlZl1v
         Lcu3RyW0fzrUzFfDEn+V9oCiKeYWI1oHzYJEHuHLJdA2HaYBs/2ZxpWivy/fj5bNkgCU
         WophQg9Znj00/fSq/x0vb+RuTaf3ruEyplMPTR76I6GC0KVuqYnXrnUO6lSkxQLynN4f
         NGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696429490; x=1697034290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVKBCcPpDCxr3rhiKMsHdrcSvEVmztxq1sjsldYXfrQ=;
        b=Q7hf3oe32tlXbQZpsJD/VMrsH4M0Uxffn2PG5C2CQexbdnnsRIdS0zPXuQrYNpd9T7
         +AwpzyF0Z+sEa5NlFhKdAONyUwAC9VRouu25REMSBjq/YHbd9RP7LbU9f3GS5utuRJ58
         J4PeGzGGDG5/sP7FqXEcehiHQX57Ih6ss3nrPoH5PHaaLPjKCHueLqGkVMMt0EOxILjm
         UNvZjtyuD6ySjQd7cYZfG2dtjl90EiOzZ3LGDmkNf3etgVSF1Yo3JD6haQw2AN0BEhvN
         8nEofIojYXDVC3vjTbnJCT6jcs9MzqhBbo7f9qY1GynDevSCf572Am2OABuuEwKXMPZF
         JqZw==
X-Gm-Message-State: AOJu0Ywbx3oto7cEO3VmvA0dbAwnnTIiF4ru/9fkIEslaH2bcG3qKfA4
        TdcHr5NXYQkZ+SAnWqVObpU=
X-Google-Smtp-Source: AGHT+IENLCcZQM08V9aEbkBamP9+BDNu4+V22aNgfg7SblU8BFGUGKFUS9UTOVLWbZKtDRg8lZq6SQ==
X-Received: by 2002:a05:6870:f708:b0:1d6:567b:7a93 with SMTP id ej8-20020a056870f70800b001d6567b7a93mr2700648oab.11.1696429490127;
        Wed, 04 Oct 2023 07:24:50 -0700 (PDT)
Received: from penguin ([205.220.129.20])
        by smtp.gmail.com with ESMTPSA id x1-20020a0ce241000000b0065d89f4d537sm1353689qvl.45.2023.10.04.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:24:49 -0700 (PDT)
Date:   Wed, 4 Oct 2023 07:24:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Szilard Fabian <szfabian@bluemarch.art>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk
 table
Message-ID: <ZR11lNAxw9yQ6shj@penguin>
References: <20231004011749.101789-1-szfabian@bluemarch.art>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004011749.101789-1-szfabian@bluemarch.art>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:17:54AM +0000, Szilard Fabian wrote:
> In the initial boot stage the integrated keyboard of Fujitsu Lifebook E5411
> refuses to work and it's not possible to type for example a dm-crypt
> passphrase without the help of an external keyboard.
> 
> i8042.nomux kernel parameter resolves this issue but using that a PS/2
> mouse is detected. This input device is unused even when the i2c-hid-acpi
> kernel module is blacklisted making the integrated ELAN touchpad
> (04F3:308A) not working at all.
> 
> Since the integrated touchpad is managed by the i2c_designware input
> driver in the Linux kernel and you can't find a PS/2 mouse port on the
> computer I think it's safe to not use the PS/2 mouse port at all.
> 
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>

Applied, thank you.

-- 
Dmitry
