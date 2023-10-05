Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92057BA534
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjJEQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbjJEQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5260787
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:49:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875EDC433C7;
        Thu,  5 Oct 2023 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696520958;
        bh=WIN9EstFELLLPzrqd4Mkhs3wLKPNhGefG3n02Se0ACA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VI+kvJYlwNMuahYX9iwV/fRCzWl0ylPGM4MqVru30c18mxeoS80j/jZu8+TLEe8QX
         E7J/9KzBaCPFaTAtU89I6HGzVQe234KHYeNRCaasRD72WzTugymQshdiCxerw6Y0RI
         Bx8bBxvXMjFigiRS8PQFZ2hE3RNHIu//n5ZkBj3x+D6hMUvjEDAU9/EQ8ureYDpwSl
         7z9qTSTHRESoZ8IuYjBFhyVaY5URK+WCmX78kUsLT7/aVW+W3sDhiJ9v3H44dQO1Od
         goFlxsFtW/zpeztyA3NwOsIjaShI6NLhbSo4O9630iU5U97KGJM/oT/6mHMkXS4Llp
         eRrivGJYdhT9g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qoQbW-0004c6-1z;
        Thu, 05 Oct 2023 17:49:35 +0200
Date:   Thu, 5 Oct 2023 17:49:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>
Subject: Re: [PATCH 1/3] staging: greybus: raw: make raw_class constant
Message-ID: <ZR7bDtBjPyRXkIKT@hovoldconsulting.com>
References: <2023100533-broadband-hunk-9e91@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100533-broadband-hunk-9e91@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:34PM +0200, Greg Kroah-Hartman wrote:
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
