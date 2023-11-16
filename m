Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1F7EDEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjKPKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbjKPKy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:54:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F271B6;
        Thu, 16 Nov 2023 02:54:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35BF522937;
        Thu, 16 Nov 2023 10:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700132051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UM81hjiA/5PsIR9F0SaCot2R2mHkt+tK3uVE8YjyK4c=;
        b=V/RNr1QO/+SUIOycRPtcR5edmZ50pAafqg3DTWXfMAA4sI7BqrW9BQ/p3uKURRFOcL96Ew
        oZPUgaMOU5BXPi9ejVN00mAy7SmuoXm4u3CiWo+ATjAd9Sfi5rR9TUbtAUeLQt2K9/k1RO
        miYp2d/ogAVZVGS3kVgWnJgE3KnJcy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700132051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UM81hjiA/5PsIR9F0SaCot2R2mHkt+tK3uVE8YjyK4c=;
        b=AbFHRE+g9SgKaqkkFR5dnwG8jLhBnQ5a4qfCXQkNBo+MrxyJvGFvB7GVNW5rYzhN7PuvY8
        elKIOyh6e0cnHbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A94F139C4;
        Thu, 16 Nov 2023 10:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UopNBtP0VWUaNwAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 16 Nov 2023 10:54:11 +0000
MIME-Version: 1.0
Date:   Thu, 16 Nov 2023 12:54:10 +0200
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Umang Jain <umang.jain@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Guillaume GARDET <guillaume.gardet@opensuse.org>
Subject: Re: [PATCH v2 00/15] staging: vc04_services: bcm2835-isp support
In-Reply-To: <20231116005030.GA21041@pendragon.ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231115195947.GD29486@pendragon.ideasonboard.com>
 <58fe01b9-5fb6-451c-a759-c6a5afd695e3@gmx.net>
 <20231116005030.GA21041@pendragon.ideasonboard.com>
User-Agent: Roundcube Webmail
Message-ID: <45c0e7bbb2ed91ec559cdbf2d19ad80e@suse.de>
X-Sender: iivanov@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         BAYES_HAM(-0.01)[50.46%];
         RCPT_COUNT_TWELVE(0.00)[15];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmx.net,ideasonboard.com,gmail.com,vger.kernel.org,raspberrypi.com,lists.infradead.org,lists.linux.dev,marliere.net,opensuse.org];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 2023-11-16 02:50, Laurent Pinchart wrote:
> On Wed, Nov 15, 2023 at 09:57:52PM +0100, Stefan Wahren wrote:
>> Hi Laurent,
>> 
>> [add Ivan & Peter]
>> 
>> Am 15.11.23 um 20:59 schrieb Laurent Pinchart:
>> > Hello,
>> >
>> > On Thu, Nov 09, 2023 at 04:02:52PM -0500, Umang Jain wrote:
>> >> This series aims to upport bcm2835-isp from the RPi kernel.
>> >> It is developed on top of staging-next which comprises many
>> >> VC04 changes for it's de-staging. Hence, the merge of this
>> >> driver is targeted when VC04 is de-staged completely (which I
>> >> have been pushing), but it can be helped getting reviewed meanwhile.
>> >> Hence, the reason for posting the series.
>> >
>> > Related question, what do people think about dropping the legacy
>> > firmware-based bcm2385-camera driver once this gets merged ?
>> > firmware-based camera operation is deprecated by Raspberry Pi, and
>> > doesn't work on the Pi 5
>> 
>> i don't remember exactly, but wasn't the bcm2835-camera required for 
>> Pi
>> Camera V1.3?
> 
> If I'm not mistaken (Dave can correct me), the legacy camera stack 
> works
> only with the Raspberry Pi official camera v1, v2 and HQ modules.
> Raspberry Pi has switched to a new camera stack based on libcamera,
> which works on the Pi Zero 2, Pi 3, Pi 4 and Pi 5. This new stack
> supports the same camera modules as the legacy stack, and many more. 
> The
> legacy stack doesn't work on Pi 5 at all.
> 
>> At the end cannot speak for the users. AFAIK OpenSuSE and Fedora use 
>> the
>> driver.

Guillaume (in CC) is more authoritative about this topic, but as long we 
have
smooth migration plan I am more than happy to switch to proper camera 
driver.

Regards,
Ivan
