Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F67E041C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377697AbjKCN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKCN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:59:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C31BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:59:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC89867373; Fri,  3 Nov 2023 14:58:57 +0100 (CET)
Date:   Fri, 3 Nov 2023 14:58:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <20231103135857.GA1871@lst.de>
References: <20231030160044.20355-1-dwagner@suse.de> <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com> <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 01:11:02PM +0100, Daniel Wagner wrote:
> This particular firmware seem to interpret afi one based, while
> the this patch assumes it is zero based

>   Active Firmware Info (AFI): Specifies information about the active
>                               firmware revision.
> 
>   Bit 7    is reserved.
>   Bits 6:4 indicates the firmware slot that is going to be activated
>            at the next Controller Level Reset. If this field is 0h,
>            then the controller does not indicate the firmware slot that
>            is going to be activated at the next Controller Level Reset.
>   Bit 3    is reserved.
>   Bits 2:0 indicates the firmware slot from which the actively running
>            firmware revision was loaded.
> 
> 
> It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
> indicate to be 1 based.

All 0's based (what a stupid term..) fields in NVMe are explicitly
marked as such.  And even if that wasn't the case I'd very much
expect the same encoding for the two sub-fields.
