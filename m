Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2877C55E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjJKNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjJKNwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:52:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339BA90;
        Wed, 11 Oct 2023 06:52:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7af52ee31so31913107b3.2;
        Wed, 11 Oct 2023 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697032358; x=1697637158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRfBMqrxE6o0aXiKIJD1B2cej8T8E1hA6przV4Far5I=;
        b=LYrS7L3IfBjViW3Z9RZ+tABYnZ1HGSbII08w5j02XIs4FOeuQfu/iEWd5L0nzews/p
         vZ0cb/eUYXb8n2G038I4rkSa9QRCoM6GZt5l6wcKKkCVITuut0mrbttWpP2uzEZeled+
         cNrI59BE/eYgHGBTGn92eqxC23mZASayBDiNckEIkCiCriBUF8y1VErTeRsZLF8yVjCm
         Z/46OHmx/6BnNCLQN7AuyDQJjhmKSpSF9THwV5R3ndW4fjCkoE8B/SqqPseW026gmB7v
         RCLTElz2MDy8yQ3BG16FmkR0OB2kXqfyRezXL27F7Fp2cgoHTsA0mmeHpEH11B0wrKFp
         tA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032358; x=1697637158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRfBMqrxE6o0aXiKIJD1B2cej8T8E1hA6przV4Far5I=;
        b=jZ9nkfuLiHnqveevfzYiw8D8GrS1AJLKCsSnG9OVS4tZ5lAh5awOX/DD7xJCZ98mG8
         GCMvrGCcTUFaZD5TGrfnwbFIOPOcnb9yLejGb8Va9GafDhpwqYzoi4CUZrC1JXn5Dusb
         7qHc5kYdFqG7Y4b34DQubct2GC8/xV1iTxSHGyq5yH6NzFqpvHIMgmgMNHR2iIUI8rJ3
         LOqelKYhOPL24QUmJKT/0Bs0NL9Q7l/Zuv8SLtN9eZzMKFekHoljTUHUYyd75aJUqzzH
         eqLBEZHFK8leD/4OpDeoT1MB9wz/kwALLs/FMmHplFvN0rxtCwkOTk4wQz/Q+tR8cFGx
         /gzA==
X-Gm-Message-State: AOJu0YyAK8xqly2VYcY688O7HTDtt8KiEi6CA69GrioWzjEbl7LecB7p
        vMx2CYZqzF3x77EW9GjP/I1X3m0dh2Zd+Q==
X-Google-Smtp-Source: AGHT+IERKRBak2W9H8IrXRlSg33P8TDVttF65Q7jSVpAgPiHlg2eiHW2M/H10MzTI3w+fHsZSnvLWQ==
X-Received: by 2002:a0d:c646:0:b0:5a4:db86:4ea8 with SMTP id i67-20020a0dc646000000b005a4db864ea8mr21453719ywd.31.1697032358276;
        Wed, 11 Oct 2023 06:52:38 -0700 (PDT)
Received: from firmament.. ([89.187.171.244])
        by smtp.gmail.com with ESMTPSA id j131-20020a816e89000000b005956b451fb8sm5132397ywc.100.2023.10.11.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:52:38 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too long
Date:   Wed, 11 Oct 2023 09:52:22 -0400
Message-ID: <20231011135230.750728-1-mattlloydhouse@gmail.com>
In-Reply-To: <20231010234153.021826b1@imladris.surriel.com>
References: <20231010234153.021826b1@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:51 PM Rik van Riel <riel@surriel.com> wrote:
> Document that if a command line or environment string is too long (> MAX_=
ARG_STRLEN), execve will also return E2BIG.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>

It might be worth mentioning that strlen(pathname) must also be strictly
less than MAX_ARG_STRLEN, it being subject to the same restrictions as
each of the argv/envp strings.

Thank you,
Matthew House
