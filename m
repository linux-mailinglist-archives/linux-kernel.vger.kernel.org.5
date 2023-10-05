Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40737BA4EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjJEQM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbjJEQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415348C0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:49:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ED6C433C7;
        Thu,  5 Oct 2023 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696520994;
        bh=TgPbPYBbJgwN2oCLX+Lek+y4/6PbdViurSWD0n2UUTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXBTjE5gcUOHNxnIq2aL4LwOXH3opTV19XdUTtUj4UaTYQbniCOzPF5+bIOEKOGDp
         O60nUydPsMA8dhvY6hZUf6U4SK2dZIlj1Rh280yt8FA9eleWLzAJAHSA0tBomwvk7H
         ww3OJdfEW7U28QCt+PirZy5WMTly3xtVySAdefEbN/SMAwv4w+8f1K44kdPm9zTrHp
         huZfXvVTc5OSGb2Ar8kCQtik+FSlQx1xvxIyPewZRDEFfeTBYI51xxVA+svQfnMzLL
         Kbcs7sqCna7Uy0m2JLICkHjrKFOdwEUmbeQTsupYFs9aKlH0Wd//w9sffr40fToyYA
         qyjGkagqlXghw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qoQc7-0004cK-2T;
        Thu, 05 Oct 2023 17:50:11 +0200
Date:   Thu, 5 Oct 2023 17:50:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>
Subject: Re: [PATCH 2/3] staging: greybus: authentication: make cap_class
 constant
Message-ID: <ZR7bMwe8k3RR6CuL@hovoldconsulting.com>
References: <2023100533-broadband-hunk-9e91@gregkh>
 <2023100534-showoff-alright-6c95@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100534-showoff-alright-6c95@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:35PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Johan Hovold <johan@kernel.org>
