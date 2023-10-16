Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1341D7CA941
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJPNUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJPNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:20:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A89B;
        Mon, 16 Oct 2023 06:20:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71BAD6732D; Mon, 16 Oct 2023 15:20:13 +0200 (CEST)
Date:   Mon, 16 Oct 2023 15:20:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Message-ID: <20231016132013.GA26925@lst.de>
References: <20231016070211.39502-1-gmazyland@gmail.com> <20231016070531.GA28537@lst.de> <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:24:16AM +0200, Milan Broz wrote:
> I think it is blocked in USB layer as not running command enumeration,
> SCSI SECURITY will be never sent to the adapter through USB.

What is blocked?

>> besides the fact that the statement is fundamentally wrong and you'll
>> start sending ATA command to random devices.
>
> So what do you suggest? As I said, this exactly happen if you configure it from userspace.

If the USB maintainers are fine with it add the translation to
usb-storage as that's where we deal with these quirky devices usually.
