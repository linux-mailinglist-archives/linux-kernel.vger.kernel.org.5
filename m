Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927388056D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjLEOJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjLEOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:09:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77190
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:09:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBBCC433C7;
        Tue,  5 Dec 2023 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701785367;
        bh=zs/eMd88+gmmQRjUvcHkcoCYPI4L0Dw/e1tToZkeGMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBqoUcG1F9QafYcLtATQFwFvTjfacezx+nVUGTQsISkgU1nMRmiMcX2MkvjYCZRj5
         mQowI6duEjfTHH0iR8M5qbhPOo8UuRjJ4Wb0wLkp3Wr+MNL3YEKdyoRT/2h4myebrS
         ZvuRAOJ/wslBIbqFS20ixZGUMIf3OSqfxT0iCWh+FGyRzXpJFD7rQ20Z+2NAZrhD0X
         5wKZ/ioqRZ3bVQ6buS4cGlANFO6/ArT6Kzb5gXxLjNWRbSqQDC5K62ORZuUU1M1usH
         297UgiQ3Vc/f6b75wudcgDQ3rPyqVrhjQ39YQ8nlHptU9nQNgqeGyVHLOq9XZ/jkYi
         l5EKkn8sSXjlg==
Date:   Tue, 5 Dec 2023 21:56:54 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Message-ID: <ZW8sJoTEKVmDdk5Y@xhacker>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
 <20231116175959.71f5d060@kmaincent-XPS-13-7390>
 <20231117014038.kbcfnpiefferqomk@synopsys.com>
 <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
 <20231121104917.0fd67952@kmaincent-XPS-13-7390>
 <20231201100954.597bb6de@kmaincent-XPS-13-7390>
 <20231202002625.ujvqghwm42aabc2f@synopsys.com>
 <20231205012745.nt5gxlim6gljpi36@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205012745.nt5gxlim6gljpi36@synopsys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:27:56AM +0000, Thinh Nguyen wrote:
> 
> On Sat, Dec 02, 2023, Thinh Nguyen wrote:
> > 
> > Hi Lisheng,
> 
> Typo, I mean Jisheng.

Hi Thinh

> 
> > 
> > Did you see any reported issue before your change were applied? If not,
> > perhaps we should revert the changes related to soft-reset for this.
> > 

It seems this patch brings more issues than solved, I think reverting it is
better. 

Thanks
