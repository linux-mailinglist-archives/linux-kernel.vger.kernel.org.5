Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D894B7FB5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjK1JfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1JfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:35:05 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87392
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:35:11 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cc589c0b90so52451537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701164111; x=1701768911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBMv/wA3lNFrWGMX6+56IOyhOxT06+Dvulg5J77uN3Y=;
        b=aGw0GJKoy5Zs2Ci5PBqA9VBeSD4lTDQtrbiufAyNySXfx5HzqyHsA2gui024NQazS5
         IGaoR03bw0nVrMK0TJOcT0A+CDha5lvvE8Itw3CKyp4+SvmvvbcgxyiEClkRbJDG1czA
         9GY++yajKWL2GNdgq+nDUeNYTD67vNFzkZwJ5LlR/sTdP5NmUB6DPZ9gh7WMGd7kPyC9
         V271vRfOVIsWmK9XI6gmW1ArVyDUJYs0oEpKaQKy48Or6Qf/jGlssRjFItQPoKEd+PLL
         h6vUIBtoNxv3UEpr4E0YGTdtWrt80dMHLw8OeV38sT4xvyU9Mi0dEMs5g8o7UGtKPoTE
         H18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164111; x=1701768911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBMv/wA3lNFrWGMX6+56IOyhOxT06+Dvulg5J77uN3Y=;
        b=LOIJPaqeovOFX03CvsePiSKnrSmPuPqkoFm8p5qanpM0Lv6OlDSDPi4aAwmz9X721d
         sCgtmWw/UFqlzoAuym3CRn4+kmEM82OBR0cg4gwSn2S51/vFRlN3LrPRkju+X0nU2low
         byQ03iR3LsA04IvtfvdZrQIwjWvXH+QqxpjWt0HmOrDzMOxoxG6bC0DehOnnkaN/qwv1
         hj2jken+/cJ9MiHG/O9YbDPDzOrJVkhHsXq/GigG4XaE/2i9bvC2hO0Xn6+3ka9hLgWZ
         TYKUF4oDPMX4u3OMGe+aZ2axSOFgyeOL9O+eCL9Wt+N9ajiiE0SKaWvzgwpH44/9v1vf
         n/qg==
X-Gm-Message-State: AOJu0YwUdjy2CeYPGS76Sfcnvsiv3AdjSi6OwC//cd+deZGE1R1YCr+n
        45MeMp7mILHymaPucGwaWpvNK3d9Zn0b7zQ3hR1GKA==
X-Google-Smtp-Source: AGHT+IG//mF/Mgu+rXsQ4abhmBG1HAacPL2F14QYFPta7ZOzDia7ZILCE9dR/tAtxG02TGkTbCFAp2UKsb8hRCDJ0d8=
X-Received: by 2002:a05:690c:288f:b0:5cf:4e73:9444 with SMTP id
 ee15-20020a05690c288f00b005cf4e739444mr8498457ywb.42.1701164110732; Tue, 28
 Nov 2023 01:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231127232542.GB25590@pendragon.ideasonboard.com> <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
 <80be087e-0341-487f-b6d9-8772d7c6128a@linaro.org>
In-Reply-To: <80be087e-0341-487f-b6d9-8772d7c6128a@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 10:34:58 +0100
Message-ID: <CACRpkdZmowhDhCgnEYokjQC8T0930ZKEr18f5ZsM=ZmD0PDGig@mail.gmail.com>
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
To:     neil.armstrong@linaro.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 9:30=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

> You can apply them now, or tell me if you want me to apply them.

Please apply them Neil (to drm-misc-fixes) order 2, 1, 3 for bisectability.

Yours,
Linus Walleij
