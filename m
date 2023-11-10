Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB47E7FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjKJSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbjKJSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:01:49 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FF29536
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1699612775; x=1699871975;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ktdtSKOA9fil4F06AF8zSWq3uMPFOkrgZZS6atSxG4D6py1timaFJz9vuwidShDJf
         V2RIS55K9uRYUGW+4sHxFX3FGI3PF0YEihYKn+pDU+b8CIaK2JujJxhx0/jILFCkXp
         QNshvnRllSNMTK6TxC0l4H+Nv2RvnI5qaEFMkBHwoLEdK3A7yuxpSOM0l3iSt19iVJ
         KYqxD1MIJAE/KasNMSmL3VXPEAW7nQv5zp58jNLVF0/eXgkWKYIDTbo3BLXWfTU/0b
         5uXlUc4LuM+nOgHRNCJN7w/KrC6Gaare/kFQOEczKwMhvJEXHiZXC+PdT04ytZNcAL
         uPLKuIMxg400Q==
Date:   Fri, 10 Nov 2023 10:39:17 +0000
To:     Javier Martinez Canillas <javierm@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org, Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] drm/todo: Add entry about implementing buffer age for damage tracking
Message-ID: <Qk7PzUNb_mQOUoclJb_UZkCxPr6GpbX-DftrnR9OKDwSfdDHuwhUnOXbqKU-M_v6q1YgEphShJYnc9o-LW7pN6bMOiNbpcVBsrDvUofFs_M=@emersion.fr>
In-Reply-To: <20231109172449.1599262-7-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com> <20231109172449.1599262-7-javierm@redhat.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
