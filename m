Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD67DC614
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjJaFsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJaFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:48:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C87E8;
        Mon, 30 Oct 2023 22:48:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AB9C433CA;
        Tue, 31 Oct 2023 05:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698731312;
        bh=ZL86179SQNnH59nO9ZdsjOEwSLJlQ/T8PyWZqwTE7cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl2xXr8n+alSL/G+gmf7W7osy2QKqZ/XO2v0vxwyI1mgZzbPlnmeavVHcWzMVQTZ1
         boFAFoTtuz/nV6SJ49p0TSyf5SsSQw7rXf6Zg/6xhbAXqvDQ3vZmkQoBlUkRDkSHkK
         2GyYv5I7h6c3ZBh+IWHlOc42jk8oRV4ESdsAIcA8=
Date:   Tue, 31 Oct 2023 06:48:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        dillon.varone@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, samson.tam@amd.com,
        SyedSaaem.Rizvi@amd.com, aurabindo.pillai@amd.com,
        stable@vger.kernel.org, daniel@ffwll.ch, george.shen@amd.com,
        alexander.deucher@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: remove redundant check
Message-ID: <2023103115-obstruct-smudgy-6cc6@gregkh>
References: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:17:48PM +0200, José Pekkarinen wrote:
> This patch addresses the following warning spotted by
> using coccinelle where the case checked does the same
> than the else case.
> 
> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: WARNING: possible condition with no effect (if == else)
> 
> Fixes: 974ce181 ("drm/amd/display: Add check for PState change in DCN32")
> 
> Cc: stable@vger.kernel.org

Why is this relevant for stable?

