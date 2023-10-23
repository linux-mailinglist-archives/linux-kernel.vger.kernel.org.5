Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37E7D2BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJWHyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjJWHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:54:15 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A0A6;
        Mon, 23 Oct 2023 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698047649; x=1698306849;
        bh=U0MZUFxkg3+UOPqNFrbWaEyCbKpVVLhO0H5Klvvg8Vk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=lL+VJACho1UvWH2TpvqzgGk2GEaCmjd2Cy0LlMg7A0/M9fARj929MAo2vaP+Dns2L
         UszlbpoHPjzn0iHan+IL6h7UGH5F4TREJFPUo7xUZaXQQZZ4RJdpQjPFCUDS3Jh3La
         R5dnRt2NqZGcxI4wYqOUm4U/e3Y1RH46n9DBDsJwtrclJko6uyb22CHp8VJe8BhPcb
         VbtRca/sGejOsaUxY5JbR4QMkuj2dq1XoNQZOdJR48hREt0o1VtyIoZ2XvJFwq1B2I
         uhY4vAHNp0YI10dWDi1eX6PdT2RcHpG7xoFcEn8IktqIO6XZPRirxYVSKk6pbQKb/P
         DSv4qJNVwfWtA==
Date:   Mon, 23 Oct 2023 07:53:57 +0000
To:     Albert Esteve <aesteve@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v6 1/9] drm: Disable the cursor plane on atomic contexts with virtualized drivers
Message-ID: <JK64byEJdVeFlotnfIzSsyiHWQCs-Luun_S8XqvJ4jG1In3fsBD6FBYZHcmKEvwDOas123VjhJoONJLALDRa5TCdA8avSMEN0xXA6oE8sVU=@emersion.fr>
In-Reply-To: <20231023074613.41327-2-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com> <20231023074613.41327-2-aesteve@redhat.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Simon Ser <contact@emersion.fr>
