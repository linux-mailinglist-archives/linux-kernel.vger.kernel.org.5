Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFEE7E0569
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjKCPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjKCPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:18:31 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB171B2;
        Fri,  3 Nov 2023 08:18:28 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 9CECC5201D3;
        Fri,  3 Nov 2023 16:18:27 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 3 Nov
 2023 16:18:27 +0100
Date:   Fri, 3 Nov 2023 16:18:22 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>,
        <s.shtylyov@omp.ru>
Subject: Re: [PATCH v7 1/2] usb: xhci: Add timeout argument in address_device
 USB HCD callback
Message-ID: <20231103151822.GA101660@vmlxhi-118.adit-jv.com>
References: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
 <aa328f6d-be12-45ef-42dd-2b4dc0821771@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa328f6d-be12-45ef-42dd-2b4dc0821771@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:45:54PM +0200, Mathias Nyman wrote:
> On 27.10.2023 18.20, Hardik Gajjar wrote:
> > - The HCD address_device callback now accepts a user-defined timeout value
> >    in milliseconds, providing better control over command execution times.
> > - The default timeout value for the address_device command has been set
> >    to 5000 ms, aligning with the USB 3.2 specification. However, this
> >    timeout can be adjusted as needed.
> > - The xhci_setup_device function has been updated to accept the timeout
> >    value, allowing it to specify the maximum wait time for the command
> >    operation to complete.
> > - The hub driver has also been updated to accommodate the newly added
> >    timeout parameter during the SET_ADDRESS request.
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> 
> For the xhci parts
> 
> Reviewed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
>

@Greg KH, Friendly reminder.

Thanks,
Hardik
