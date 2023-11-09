Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D2F7E71D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjKIS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKIS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:58:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865B3C11;
        Thu,  9 Nov 2023 10:58:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc1e1e74beso11079585ad.1;
        Thu, 09 Nov 2023 10:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556320; x=1700161120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Six/9bBjHcTyI2QBtTW3JkpzmsPtCMRe0zm/Z/EU684=;
        b=jPO5SeILCNU138ka9ItnxLIWtecyNATqOav4D0IDsn18TrZ8NHBTjpuoZSahwGnybh
         776mW6VhyHu1eyeYiu+d5mYjRV/aaXI0vvk28Y4CFjKkTCJ61+r9RWtO0bhf0xKY+ZWs
         104UfymOt2Mm2cwG0ENX2oDcX4gJF6VjrGq44hZl14iw+2F2hHhID557Yns3YU/0bOQz
         OFOVt4JM6Hn+iW2m9CeCBy4GyC39W4bR4reVC297KuC4V9bTFTlxWLvZwH+pJuzlosrQ
         Q1fsNwzyt8kN48QwQW2il80tshqz6LG8kvK3Umd3lRDcRQjO09VaUOmKGkgRQVAHlb+Y
         Wk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556320; x=1700161120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Six/9bBjHcTyI2QBtTW3JkpzmsPtCMRe0zm/Z/EU684=;
        b=nsAoajJaJi3IUIzK5Lf6F15vWGpUp5iOjcd35DtMXcTFJhs6nRm8I5rNJK03adCV3f
         mZATTYEIgapWv8TZtgym1wF3qONMg/g4TLJCOe+GQps2xW3U28sPfF+rggxHbCn21X8g
         x+sMRyh7aEmq3POx7pDqW2oXLZ7jdncRCpyGTISa4oBAL0rO4gTVHMV3x+q5QIHT9i8Z
         cGEsotFcDHI9RTQ9UkgNXHv5bwl29XEMPE5dkR09oQLTLk1Yyvp2Vk+dJWBGZL4/O6G/
         hv4DV9T7jtWzxxUbx8SsbgKtFRntpDGoM6W04Kuf7eMxi8hSrCKUJLPlDJXo5aUtL0bU
         COdQ==
X-Gm-Message-State: AOJu0Yw2T3CjAgZaSRdMz/5RH725Mbyw8lGZPQQjsJOYxwJPCs4yebzj
        AGHGr2UNDrWRnMmU5nvk0DE=
X-Google-Smtp-Source: AGHT+IFliqdoDfydMjE0QryOcjH8kwV2y9hGfW2Q/6rQp6nI7gIrGvf4y6vocxCwRMvgq8KWMUwVXg==
X-Received: by 2002:a17:902:8c86:b0:1cc:7e40:de4a with SMTP id t6-20020a1709028c8600b001cc7e40de4amr5824643plo.58.1699556320425;
        Thu, 09 Nov 2023 10:58:40 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001c9b35287aesm3866699plz.88.2023.11.09.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:58:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Nov 2023 08:58:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        jiangshanlai@gmail.com, song@kernel.org
Subject: Re: [RFC] workqueue: allow system workqueue be used in memory reclaim
Message-ID: <ZU0r3rzjH1cIzqvH@slm.duckdns.org>
References: <20231108012821.56104-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108012821.56104-1-junxiao.bi@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 07, 2023 at 05:28:21PM -0800, Junxiao Bi wrote:
> The following deadlock was triggered on Intel IMSM raid1 volumes.
> 
> The sequence of the event is this:
> 
> 1. memory reclaim was waiting xfs journal flushing and get stucked by
> md flush work.
> 
> 2. md flush work was queued into "md" workqueue, but never get executed,
> kworker thread can not be created and also the rescuer thread was executing
> md flush work for another md disk and get stuck because
> "MD_SB_CHANGE_PENDING" flag was set.
> 
> 3. That flag should be set by some md write process which was asking to
> update md superblock to change in_sync status to 0, and then it used
> kernfs_notify to ask "mdmon" process to update superblock, after that,
> write process waited that flag to be cleared.
> 
> 4. But "mdmon" was never wake up, because kernfs_notify() depended on
> system wide workqueue "system_wq" to do the notify, but since that
> workqueue doesn't have a rescuer thread, notify will not happen.

Things like this can't be fixed by adding RECLAIM to system_wq because
system_wq is shared and someone else might occupy that rescuer thread. The
flag doesn't guarantee unlimited forward progress. It only guarantees
forward progress of one work item.

That seems to be where the problem is in #2 in the first place. If a work
item is required during memory reclaim, it must have guaranteed forward
progress but it looks like that's waiting for someone else who can end up
waiting for userspace?

You'll need to untangle the dependencies earlier.

Thanks.

-- 
tejun
