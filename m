Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEA7EC9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjKORti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKORth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:49:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867361A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:49:33 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso5657737a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700070573; x=1700675373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rD3WiIjcHVWht+bRoyz5WPCyUUboXlGuOAtDZ7BuR4Y=;
        b=HL7teC/dFsL6nhWGP8XRvC3I1hAH1404skG3QW+KqliDXcK3kiO6YDQ3JnutiTzpNa
         MDUFtqnMl8mS5Rb0XdsPJ9uXJ6X1zmQqu/hCDJRYK7C0Nb9UVzBj2YADferoK9nr1MZ6
         DtnJ93aBiqq8q24OHqy/JNRcz6FbegsdyNd44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700070573; x=1700675373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD3WiIjcHVWht+bRoyz5WPCyUUboXlGuOAtDZ7BuR4Y=;
        b=E7t0XIZsHp1n+bQYV+yvwSbgS+JF9iKfXIodGRdPy71fH6kzYlox0ljHGotiSrEKD/
         DlRwrvJUDPI7VSRPfZ3XiffyESxKqH6yCEi2AJ0wYTONIxuWIi0bXaZQJKjqbthgoN2d
         bLfhIbrx3EqZ8iPn4cZlzroBvWkPsU+N6NGYzsgoeXBnh7IotWl9SMRB8/UDDk7nqWZ2
         a2hO77aB91Aq7WDtP/woo5HpwBPWZNBfxstKnoAKIYkiDGLNadrSkezhLxN0pj4Tb1p9
         2/nejUfRaKfA2hOmlbaBn4X63uD/OrjSHNCvUT051SAXDzgA5mwJ8IaZHxaB//u8GFtm
         BU3g==
X-Gm-Message-State: AOJu0YyvkPOiP/rwtkFl3UtPIohyijLO2FzaCoLjTVjPvkQx0XcVmbeo
        dLjuW2A8tHIDmfHf74uxeb/ni6i6kfmAWJuzcmBeMjMK
X-Google-Smtp-Source: AGHT+IGpmlqewDarAywsnMa7n04xYqUuCS4rlMCE2QKXA46apMCUxu5GyilgrdJ+vePrD+IEy8Q6pg==
X-Received: by 2002:a05:6a20:7487:b0:148:f952:552b with SMTP id p7-20020a056a20748700b00148f952552bmr15559858pzd.51.1700070573014;
        Wed, 15 Nov 2023 09:49:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b0068e49cb1692sm3068013pfh.1.2023.11.15.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:49:32 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:49:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: submitting-patches: improve the base commit
 explanation
Message-ID: <202311150948.F6E39AD@keescook>
References: <20231115170330.16626-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115170330.16626-1-bp@alien8.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 06:03:30PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> After receiving a second patchset this week without knowing which tree
> it applies on and trying to apply it on the obvious ones and failing,
> make sure the base tree information which needs to be supplied in the
> 0th message of the patchset is spelled out more explicitly.
> 
> Also, make the formulations stronger as this really is a requirement and
> not only a useful thing anymore.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Yup, I wonder if making "--base=auto" a default in git might be a good
idea too?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
