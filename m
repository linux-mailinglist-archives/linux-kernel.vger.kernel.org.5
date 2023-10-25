Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30D7D7468
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjJYTfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:35:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4597137;
        Wed, 25 Oct 2023 12:35:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc04494653so342935ad.2;
        Wed, 25 Oct 2023 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698262518; x=1698867318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PfZS2v4rKeH7WpwcRNnwJfVzvCUVvoLwgj4JaCkmXw=;
        b=fe5z7E0HoVH30aW+MgpJk1dmyB61G+BkcDfsgeLtcinrQM2oa0jjGtzadSZm6Jl+mt
         c2+aK6zUIJwKK32TXsm37CUwv5CSHQ8/MGJj8lZlnSLxtOtwQED7w5bC3LBWxHZyp5FP
         QPOdAFcrBov2pKOL5BNn2HC90ebmCqXcoIzGU/gRRx5w75OFeMlMUB1T7wnV8rpYx1vs
         TMROI1fen+497VMK81E6lA4F0csNAFVG/OMNoALX6YxkS9igzyl1T50qVSQ3FCn2kQ7H
         NkIS6H0aTqSeZme0yxMdPk0iQMWVfrCGXmDGwHUgtuqRgvJ9PS0YKXcl+gNYabwj2mIs
         WjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262518; x=1698867318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PfZS2v4rKeH7WpwcRNnwJfVzvCUVvoLwgj4JaCkmXw=;
        b=gy8AVH2Xc+OAAgxByCPGp+vg0wgYsGi9po2+xewhZBzmadRp3xrq96YUL+o4FmQZ5+
         0tMb2nLatISvBcjEWwK/pMeNhcoCCRNILqRcmuDlbXmwhq59Db5w/SVCX2sMJKBACy8k
         ZZGkK6HYSr0aCQFSYoY6b2EA5YizQzEsQ5Hp3QQumepIyeH1pNPyxg4yxihUaFdhAZms
         tAkqnKzORQs9y/9GDfaqBmbHVr3kRqJnVGzMXmYAXOEDb+WKI9x5AT7FI/H3wnk7B2k4
         3A12EiyLhr3m7S/CpWiCXdmFOY9LxRGVZOGZ63KSBrutvctNCHTMtFZrAEeRCRPdpZAr
         TzmQ==
X-Gm-Message-State: AOJu0YySBUkHml5HYxRZ3iIFAXbTOuj7VuSuuzF/JywgQaWJLn9NGQNy
        p9bSuk53oPWBM8taHvQTUmk=
X-Google-Smtp-Source: AGHT+IFuZDGO+Q1SobzYFl2F2V2CeAc/CplsJkrHeRr4Ij0e5NGsJhhmn7fzCV+5gl3nEVZgpnvHqw==
X-Received: by 2002:a17:903:2442:b0:1b7:e86f:7631 with SMTP id l2-20020a170903244200b001b7e86f7631mr16157155pls.19.1698262518246;
        Wed, 25 Oct 2023 12:35:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902db0b00b001bf11cf2e21sm9501786plx.210.2023.10.25.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:35:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:35:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ellie Hermaszewska <kernel@monoid.al>
Cc:     eugene.shalygin@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Message-ID: <d013e9a3-df0a-4b8f-a1f3-db3cbd32812f@roeck-us.net>
References: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
 <20231019135640.434752-1-kernel@monoid.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019135640.434752-1-kernel@monoid.al>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:51:58PM +0800, Ellie Hermaszewska wrote:
> These are two separate statements, describing the set of sensors
> implemented (those I could verify) and the specifics of the T_Sensor new
> to the X670E motherboards.
> 
> Best wishes,
> Ellie
> 
> Only the temp sensors that I can verify are present.
> 
> T_Sensor is the temperature reading of a 10kΩ β=3435K NTC thermistor
> optionally connected to the T_SENSOR header.
> 
> The other sensors are as found on the X670E HERO.
> 

This is not an acceptable commit description.

Guenter
