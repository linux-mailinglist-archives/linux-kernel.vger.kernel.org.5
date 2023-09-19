Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E77A5CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjISIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjISIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:34:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD516E6;
        Tue, 19 Sep 2023 01:34:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC501C433C8;
        Tue, 19 Sep 2023 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695112452;
        bh=GjUd5JrPVUTZ+uXOPJyhDhqF0PGaayXuvljzgD4jIT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtiGWzxAv4yxncx/+5wXNovuRsCQi+rJ17Kf++2HQ1/8ECj4pQLL7tZve/THkefpk
         qhgWsqNNJXs22cGByYLHp0hUwPLl8bJqdQnidn3+jh9IVkLuzQeRV0sJPmxFvzLEtI
         d46W8WsykEAMxJxacbzi5cnRJTm/aEilZUhCHTM8=
Date:   Tue, 19 Sep 2023 10:04:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
Message-ID: <2023091955-dried-popsicle-f3d8@gregkh>
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <20230918181044.7257-2-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918181044.7257-2-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:10:44PM +0400, Ivan Orlov wrote:
> +
> +#define DEBUG

Do you mean to have DEBUG enabled at all times?  Shouldn't this be a
runtime issue with the normal dynamic debug infrastructure?

thanks,

greg k-h
