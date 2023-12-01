Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23F800AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378837AbjLAMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378794AbjLAMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:25:38 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8A10D7;
        Fri,  1 Dec 2023 04:25:44 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id D8D875C0206;
        Fri,  1 Dec 2023 07:25:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 07:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701433543; x=1701519943; bh=8L
        9CprDdm9b9J6FUNGfqCgNU8FEUAwtyKRriGeA6wEY=; b=kyfdNyjpr2uVqvHhBj
        y+o3anI0mpxnn8Zt7z20rIjuOpA5LYhTCXS/xXKktvXzIViWdtCnK53znD9tBD/5
        sG2TyaETD58U0hygGdSVLBHQpMKLOnaXMKN0gR9Vvq/ijTnTO70Jj+G13vfSy+22
        JqJo3ZTyQkn1AffPaXqt9BGa2q94qMuf/IVyRqH+N4PL82uDMHZgOwXZ0oGo1rUn
        zyXUYVTmfxJPlR8uC0bJ41sPEIMC95wk1c2kJtmyzmtdYAw/Y+FFFgiZ1E+AzOnl
        EQ4kElEDQZJlThgAw/Lt8sZdfkmQFi09la6I6Rl5PTyQnpT8vVS4Ew7Fz5qLtxd0
        c82Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701433543; x=1701519943; bh=8L9CprDdm9b9J
        6FUNGfqCgNU8FEUAwtyKRriGeA6wEY=; b=ltRo/qHMHelfPOkPLa99rRPsWO8x3
        e01eAsZh8AD7f26pMMHWOmI1b6Ep7XKh58PrVghPYlpR+yWZ6w0HotXpNqKlQsis
        eeZ/rSzMrQiOO9Zj9V8NZQmWZcWk60VpgeMMVJSqWve7dzlsK692zowyjf+CLK3u
        OhrVgz0dUAvvGpO7o7r8DKgDImz2MJpFdpF2zFS60bndMZhh74SpjeRqf7zVYyDc
        9LAdfwWHYSG13tI4sbp7f4EkcD6azQdYvXDbyWnQJcNrRyeBJFn9bwHUWG8TrYfz
        jKEnigC7ZkXqlNUGkqXYo2F36jh5WBc1u92LsmI73/cPi2UoHfQ03BJmQ==
X-ME-Sender: <xms:x9BpZdQO-IoY4-R9gQUcVlfI_13Qv39KUnMH7njtsllLq1-dDUyFEw>
    <xme:x9BpZWzkVtRHF1hMPzgKSy3gRlS3xm_lqTFmjzh-4QjnjIhZQxsA6Jkb6KMTpV5q2
    8qQ3MUMYV5OSg>
X-ME-Received: <xmr:x9BpZS2iKK0y2n92vEmh1jGoZ0zOWnXueaJKoClM7MugPjd1Nww7PSy6lOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:x9BpZVDnYAiNTISocG_uA4xX43XlRAHY0dBRI3vZlC_Sywp9jk7G3A>
    <xmx:x9BpZWghGHulNc9vwJ78Of34_qiLnu2PFDR2QvGs40qJxX7IWHJc2w>
    <xmx:x9BpZZpFEJR2vnzzUrm1VdJdqeJDrehOpQrMh9fGeoYl_vOShuOfRQ>
    <xmx:x9BpZfaP7HgRAydiqm72SaIDuDZ3u3Z4ywNCXR2CYlBJz60jkUV6dg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 07:25:43 -0500 (EST)
Date:   Fri, 1 Dec 2023 12:25:40 +0000
From:   Greg KH <greg@kroah.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     stern@rowland.harvard.edu, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <2023120130-repair-tackle-698e@gregkh>
References: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
 <20231201115143.177081-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201115143.177081-1-jtornosm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:51:43PM +0100, Jose Ignacio Tornos Martinez wrote:
> When the device is disconnected we get the following messages showing
> failed operations:
> Nov 28 20:22:11 localhost kernel: usb 2-3: USB disconnect, device number 2
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: unregister 'ax88179_178a' usb-0000:02:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to read reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3: Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0001: -19
> Nov 28 20:22:11 localhost kernel: ax88179_178a 2-3:1.0 enp2s0u3 (unregistered): Failed to write reg index 0x0002: -19
> 
> The reason is that although the device is detached, normal stop and
> unbind operations are commanded from the driver. These operations are
> not necessary in this situation, so avoid these logs when the device is
> detached if the result of the operation is -ENODEV and if the new flag
> informing about the stopping or unbind operation is enabled.
> 
> Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Follow the suggestions from Alan Stern and Oliver Neukum to check the
> result of the operations (-ENODEV) and not the internal state of the USB 
> layer (USB_STATE_NOTATTACHED).
> 
>  drivers/net/usb/ax88179_178a.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
