Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C989A7BB8A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjJFNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjJFNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:12:25 -0400
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753FAC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1696597926; bh=bpFnRu/wSLaJ36e2cl256f9SsrE5uKGcDH1qTSECnRU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=mif+BjF/RrX5QmfsFXDVzq1+LjM6YDhcbbFGCbpo7r/S/YgH+cCF4bAf24tPOiVsB
         CbC8kp7ztBLFm6NePvANL8dXzHtqIGtVclbNxornv9JAO9dEG3elKRBZ3oMrWBwrl7
         85RScX+L/ucfbQdwv4niVTIFhdDtcLcHBG2gkmZ0=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri,  6 Oct 2023 15:12:06 +0200 (CEST)
X-EA-Auth: vQHFtkQs5JwsO7pjZoUof/uBK5tNUlViDT4elZhpx7PPqUypgNv2GuvWR2ovBDzoWwk5+rN1GRS7JKpvG0VRxg==
Date:   Fri, 6 Oct 2023 18:42:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>
Subject: Re: [PATCH 1/3] staging: greybus: raw: make raw_class constant
Message-ID: <ZSAHoIN8p2ROXvh/@runicha.com>
References: <2023100533-broadband-hunk-9e91@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100533-broadband-hunk-9e91@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:34PM +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only

Hello Greg,
When you say "Now", has anything changed recently that facilitates this
improvement? Where can I read more about this change?

Thank you,
deepak.

> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---


