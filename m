Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B37A5CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjISIfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjISIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:34:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FA186
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:34:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBF1C433CA;
        Tue, 19 Sep 2023 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695112489;
        bh=Rkx4DECD6m48ZZAFf7O2RdRfTlvmBElc9OF73G6+SxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Abw9lj+V6IIjnRpF0bZxe4qrIa6h2AnsUtigH27wzfK2vhL6QQWGjJ8YswbwYFPsx
         poISWu8uQupP2ONRFhiDD6GOhFCmPC0BrmxHz3vVVDGn5Q1iZ+E9WuiK8Ux7iMfb2y
         +8zQRd3g4T0V2UPOT5da44T2Pr7wOpNf9gi32AMs=
Date:   Tue, 19 Sep 2023 10:31:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     mcgrof@kernel.org, russell.h.weight@intel.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Add reboot_in_progress for user helper
 path
Message-ID: <2023091952-amends-animosity-4760@gregkh>
References: <1694773288-15755-1-git-send-email-quic_mojha@quicinc.com>
 <2023091727-clever-schilling-3814@gregkh>
 <5f4255d1-51e9-8888-c32d-723a6a7afb5d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4255d1-51e9-8888-c32d-723a6a7afb5d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:27:05PM +0530, Mukesh Ojha wrote:
> > > +bool reboot_in_progress;
> > 
> > Bad global name for a variable in the firmware_loader core.
> 
> bool abort_fw_load_req ??

Use "noun_verb" please for global symbols so it's more obvious where the
symbol is, and it's a bit easier to manage the namespace.

thanks,

greg k-h
