Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD11758B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGSCrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGSCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:47:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E37FC;
        Tue, 18 Jul 2023 19:47:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so4738394b3a.2;
        Tue, 18 Jul 2023 19:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689734822; x=1692326822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3LLhHhYMtWdhdqQaQ2M8PHk7PsBJv7mS00OVrDkecY=;
        b=nOcqibcH3xHMnvTQntcJFBLENW8p81Amh29A0itJOBhcfyhthu2A3h60NGHtBSkgAZ
         6mT+zwCFaWiUbpXME/Qut5ZVBzVZfepjFkLU/BZx70CO9QST8PtbrDfC0SwtI0KMWW6+
         BozF4s0c7Kfv5O+LFkTtQv2fBinmc2kVBB5Eu8mrCyosSREW3Dv5yvROjjsE5WQw9+Eu
         oWknsSnG1CMPhNiqv6JhfsRXPJhObk0J/DMMm2RbdgO8/t5JBVYTuBdH86gsh5ohFIpu
         LYNuBQ3ETN1z0+5rdQBE1WD8mJHd184lWRCTZMVHFVQk/0yKdkh0sydqa8lERMnavvUt
         Y8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689734822; x=1692326822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3LLhHhYMtWdhdqQaQ2M8PHk7PsBJv7mS00OVrDkecY=;
        b=NxoY/IGUA8NlFqgJ7f6L3NfeW0xmRHNWyggD0uhbI5HjtjO9BZ6XXi0uldzo+7d1bn
         s1ySzCUQXLjPuMarnxZYwJsJjrvwxKiQaHL6eDB3+QdQCNqoyCIQwdsrxXDPM78xaPmv
         Rl3XJoJY1aDZVUhbJQD7N5KLL+Mno43/T675fHXj8Ss85LR1k+oyjQ3KUZXFVCmBuX64
         4RXxRrH4MVI27QVge5DK7Nze8fclo/e+vG+Y5zbFY1azcQmjyX8c4WS296qijOJk2Xmu
         CipvkRCXr0GFcYM0cEXrncDa8tYqGbQ4uJxAGfJQR/2/7rCmStLiepr+lM+yY1L0QSUi
         Fpmw==
X-Gm-Message-State: ABy/qLYZhMtCyHqV7ledFHvn7z4F/rLK2K2qg6dbERPA5S4UzoD9bebH
        hmeGKjPgDKKIJlmU6elW+Bc=
X-Google-Smtp-Source: APBJJlHEoYTESmIvZxFeOchMpQUI3SWdECdrCIvD6rhf5ZDEnaMOk/cYA+0rjrz2iqsLDPk9OFoDNw==
X-Received: by 2002:a05:6a00:181d:b0:67d:b924:54ca with SMTP id y29-20020a056a00181d00b0067db92454camr4633331pfa.34.1689734822268;
        Tue, 18 Jul 2023 19:47:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78e41000000b006826df9e295sm2162558pfr.113.2023.07.18.19.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 19:47:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 19:47:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 2/2] hwmon: (oxp-sensors) Move board detection to the
 init function
Message-ID: <1c5c62c1-a52c-4394-8c8c-db124452e14e@roeck-us.net>
References: <20230717222526.229984-1-samsagax@gmail.com>
 <20230717222526.229984-3-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717222526.229984-3-samsagax@gmail.com>
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

On Mon, Jul 17, 2023 at 07:25:16PM -0300, Joaquín Ignacio Aramendía wrote:
> Move detection logic to the start of init() function so we won't
> instantiate the driver if the board is not compatible.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.

Thanks,
Guenter
