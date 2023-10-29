Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3939A7DAD45
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjJ2QsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Qr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 12:47:58 -0400
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16550BC;
        Sun, 29 Oct 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=385; q=dns/txt; s=iport;
  t=1698598076; x=1699807676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5D2zXWVusUT5D91uMh671kp8XhfaR9IA8GeA9LT8GCw=;
  b=ZEPZCWfQ9ZDi6vNA4z/iXAXS+r7TKxGU3yv/NKHbGeQdVvAypPU2JH3t
   /qh//FUqFysGpDKYuhbaYCC5W+w68R9bJWtL1ChBVKAegoNoVByMW1lSe
   YyWMHVULlp2fiWtsio8YoUTS0gRGwoOGJEUF8zRLuIaaEvQOmeMB+aQV/
   I=;
X-CSE-ConnectionGUID: yOUrQ3B8Tb2sBBMrFR99SA==
X-CSE-MsgGUID: O7nFp6dkT7S8EE4VTIp6bg==
X-IPAS-Result: =?us-ascii?q?A0BCAACuYjxl/xbLJq1aHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YQHLhKNN1+IZZJYiyWBfg8BAQENAQFEBAEBhQYChxsnNAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQECAQEFAQEBAgEHBIEKE4V1hk0BBTo/EAsYLlcGG4VVA6lWeIE0g?=
 =?us-ascii?q?QGzJ4FogUgBiAkBigZCgUlEhD8+imQiBINzgnUogV0VLgMEMoEKDAmBA4MvK?=
 =?us-ascii?q?Yw+XiRHcBsDBwNYKxArBwQwGwcGCRYYFSUGUQICLSQJExI+BIFngVEKgQY/D?=
 =?us-ascii?q?w4RgkMrNjYZSyuCMAkVDDVNdhAqBBQXgRIEah8VHhIlERIXDQMIdh0CESM8A?=
 =?us-ascii?q?wUDBDQKFQ0LIQUUQwNHBkoLAwIaBQMDBIE2BQ0eAhAaBg0nAwMZTQIQFAMeH?=
 =?us-ascii?q?QMDBgMLMQMwgR4MWQNvHzYJPA8MHwI5DSssAk0DRB1AA3g9NRQbbaI+AkeCQ?=
 =?us-ascii?q?sUlhBahIEkDg1gBEoxyhjaSUZg+oxCFGAIEBgUCFoFjPIFZMxoIGxWDI1EZD?=
 =?us-ascii?q?6ITQm0CBwsBAQMJi0oBAQ?=
IronPort-Data: A9a23:izUsrq+XnrLfnqDzGPd8DrUDhn+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2QXDz+Hb62MNjPzKY1+aoq0/EkCuZTWnNZnGwZl+3xEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E/rauCxxZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4upyyHjEAX9gWUtajhFs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0K7gHGKG6ubD80ecaFHG5u9ANhBnBqRNr46bAUkWn
 RAZADkAdFWIgPi7he/9Qeh3jcNlJ87uVG8dkig/lneCXbB8GcuFGf+iCdxwhF/cguhHGPfVe
 s4QchJkbQ/LZFtEPVJ/5JcWzb332iOkLlW0rnqy+qwZ+zbfzzAu6+jAHYbrRv2SG89ayxPwS
 mXuuj6R7gshHNiezyeVt3GhnOnCmQvlV48IUr617PhnhBuU3GN7IBYRT1G2vdG9lUj4Xd9DQ
 2QP9zAhoIAy/UivX9+7VBq9yFaAvxgBS59cFOYS9g6A0OzX7hyfC2xCSSROAPQ+tM4yQT0y/
 kSQgtryBTJ09rqPRjSA9d+pQSiaMCUPaG4aYjUYCA0M/5/ooZo4iVTESdML/LOJs+AZ0ArYm
 1iixBXSTZ1K5SLX/81XJWz6vg8=
IronPort-HdrOrdr: A9a23:b0wIuaoLzUVCgic4gG4XCr8aV5oEeYIsimQD101hICG9vPb2qy
 mLpoV/6faUskdyZJhOo7q90cW7LE80sKQFhbX5Xo3SPzUO2lHIEGgK1+KLqAEIWRefygc378
 ldmsZFZOHYPBxTkdv67A6kE9wp3dWLtJyzify29QYLcemvAJsQljuQzW2gYytLeDU=
X-Talos-CUID: 9a23:OZPO+2BMpna5TS76EzhAyVQtQep1TneH1136BlWWMzc4c5TAHA==
X-Talos-MUID: 9a23:WESuyARAVeuGiOU7RXTL2zdMLJlk4JjxMxAgvMk4h+icayZ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,261,1694736000"; 
   d="scan'208";a="9274235"
Received: from aer-iport-nat.cisco.com (HELO aer-core-5.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 16:47:52 +0000
Received: from localhost ([10.61.205.52])
        (authenticated bits=0)
        by aer-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 39TGlpvi002897
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 29 Oct 2023 16:47:52 GMT
Date:   Sun, 29 Oct 2023 18:47:51 +0200
From:   Ariel Miculas <amiculas@cisco.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-doc@vger.kernel.org, serge@hallyn.com,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: document the squashfs specific mount
 options
Message-ID: <xuhuiwxtwdnqc25p3s7odrgiybuhno2mmzvqkuqd7cmpuct7tb@2vj64qjwkcq6>
References: <20231027150814.217689-1-amiculas@cisco.com>
 <9596fa83-f06c-5582-7f99-c99c67e73dba@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9596fa83-f06c-5582-7f99-c99c67e73dba@squashfs.org.uk>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.205.52, [10.61.205.52]
X-Outbound-Node: aer-core-5.cisco.com
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/29 12:51PM, Phillip Lougher wrote:
> Good idea to add the options to the Squashfs documentation.
> 
> Unfortunately some of the information in the patch is incorrect ... I've
> commented below where that is.
> 
> So NAK this patch.  Please correct and send a V2 patch.
> 
> Thanks
> 
> Phillip
> 
Thanks for the feedback, I've sent a V2 patch.

Regards,
Ariel
