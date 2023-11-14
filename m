Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9527EB694
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjKNSst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:48:48 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149CB0;
        Tue, 14 Nov 2023 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699987722; bh=xk4VJJkRC7TGgJFkx5r02wKyKfAyr4aLz0RYZy3ayxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhQa+QnAJR4Pk3KPlA+48Gmh2ITp9ed47mtb05HTP0tQdejwPqkM2jv2h4mtCDKCh
         SYFglAJCthv8+pYHr+9ZlTCRII7G4ejiS4FpUfOxpIqMQnAIo7uXgBm7UgagUw3tNc
         IilR16FV+P7fmtbYqIIX1zBcu3qs2ZKxIaf36A+E=
Date:   Tue, 14 Nov 2023 19:48:42 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
Message-ID: <6c9510b0-f9a1-4d18-b4fb-277bc8566cc1@t-8ch.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-3-beanhuo@iokpp.de>
 <f1fe8b99-bf57-4243-90bb-665c3bb4e0e4@t-8ch.de>
 <5e4f204e1ab2bb5f146b81e9809231f3a17c162f.camel@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e4f204e1ab2bb5f146b81e9809231f3a17c162f.camel@iokpp.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 19:39:55+0100, Bean Huo wrote:
> On Thu, 2023-11-09 at 15:05 +0100, Thomas Weißschuh wrote:
> > > +               schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> > > +                                               msecs_to_jiffies(hb
> > > a->dev_info.rtc_update_period));
> > 
> > What about the other work that has already been scheduled?
> 
> I don't quite understand your concern here,  I need to schedule the
> work when needed because of resume_period_update.
> 
> Work may have been scheduled, but that's okay, there will be one more
> RTC update as expected.

If it's fine to have this additional update, all is good.

Thomas
