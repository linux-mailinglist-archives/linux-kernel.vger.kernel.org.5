Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4317D9BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjJ0Opx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjJ0Opw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:45:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D4BE511F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:45:48 -0700 (PDT)
Received: (qmail 570588 invoked by uid 1000); 27 Oct 2023 10:45:47 -0400
Date:   Fri, 27 Oct 2023 10:45:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com
Subject: Re: [PATCH v6] usb: Reduce the 'SET_ADDRESS' request timeout with a
 new quirk
Message-ID: <ce31d930-b247-49d1-8bda-9fb533d4da41@rowland.harvard.edu>
References: <20231025164019.GA121292@vmlxhi-118.adit-jv.com>
 <20231026101551.36551-1-hgajjar@de.adit-jv.com>
 <55a00749-7b9d-4fc8-a470-6eabdb93216f@rowland.harvard.edu>
 <20231027095708.GA78934@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027095708.GA78934@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:57:35AM +0200, Hardik Gajjar wrote:
> On Thu, Oct 26, 2023 at 02:34:22PM -0400, Alan Stern wrote:
> > As remarked earlier, we don't need to have the "_MS" suffix on either 
> > the macro name or the "timeout_ms" variable name.  Removing the suffix 
> > will be more consistent with the USB_TP_TRANSMISSION_DELAY_MAX and 
> > USB_PING_RESPONSE_TIME names you see above.
> 
> I understand the suffix _MS in macro but the suffix is variable name was
> added after the comment about timeout unit from Greg in patchV2.
> 
> https://marc.info/?l=linux-usb&m=169687322126192&w=2

Greg merely wanted you to document what the timeout units are.  You can 
do this either by adding a "_ms" suffix to the variable name or by 
mentioning it in a comment.  For example:

+	unsigned int timeout = USB_CTRL_SET_TIMEOUT;	/* ms */

Alan Stern
