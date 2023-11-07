Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A857E47F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjKGSMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjKGSAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:00:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253C08F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:00:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83965C433C9;
        Tue,  7 Nov 2023 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699380035;
        bh=E1Bup6DoIkkVNNMrTYXE6nKFRsOD6Uc+5R8BldSYaTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MLkZVP1h6zun+CV8t6+cLhtjLAd5xTs15OrSUltDxizu0XZTtM6Gb35sHB3l6jEXl
         E/+CEMlvSxmPON/ADXkmdu8uKouuD3Iq8bUp81wLl0RMSCjiD27djBL08YNl8frEvZ
         oVNBs3W02wfi5BuDM/WfAYg6dildyqZm3pW4w3rkZythwWrxm6w694CfMkIuT7+5O7
         3yTj2GUUAu9D5/5kHXPhG5Ik2OMpdzjOi1++WTEk4udkVz7vdgTifs3mJTMgGLjV9C
         6AQZviUt+bG+cqFG+NAfZ0ys+x/vQ9JC9r6inS1qZpswWp92lshdRYTsmMTT97d6kz
         s4LhJ9L3blV5w==
Date:   Tue, 7 Nov 2023 10:00:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fixes a null pointer dereference in ptp_ioctl
Message-ID: <20231107100034.09786df1@kernel.org>
In-Reply-To: <DB3PR10MB683554F488A562C8A89286C2E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB683554F488A562C8A89286C2E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 06:18:29 +0530 Yuran Pereira wrote:
> This patch fixes the issue by adding a check for tsevq and
> ensuring ptp_ioctl returns with an error if tsevq is null.
> 
> Dashboard link: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5

Just Link:

> Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
> Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")
> 

No empty lines between tags.

> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>

When you repost please make sure you CC everyone get_maintainer 
(run on  the patch file, not the paths) points out.
And CC Edward Adam Davis <eadavis@qq.com> since his fixing similar
issues.
-- 
pw-bot: cr
