Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6147CD9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjJRLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:03:14 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC9B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:03:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 13CFD3200AF8;
        Wed, 18 Oct 2023 07:03:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697626990; x=1697713390; bh=Qd
        kwFaNQ0FjK/WhVq35+qDeyE0yEJ3deeWODbqFMP7Y=; b=ZWTHHoXg43ScgBYJPd
        W4buTGj7Easl0VFe0J6xZlBa19I3akWDO4jrIEg9PXt5bwa8xCwtTpJwr45Enhog
        hDLknc4glMMvoOyFk7w+gAeTH7jkU0RwlA1WCYDw8s6Grm/N6SrWABoSlH7RRY9T
        11WIysQcnJTz0siKDP59lOva2M77nLLZCRL76PIhWMlXcusmO664nL3bMuM+aUQo
        O7i8Y5Oz1dUOpzfoRyWRvxOiAQ99Vzf8A9PBGygftLk4ylkgdet//0G6BP8OgpMF
        /4vzlyXi+LA96Jzu5cc5z/DgsMtC9Xg/lITt5ICxNAV/9LBVlEQwG1x5sOTGjACX
        GNwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697626990; x=1697713390; bh=QdkwFaNQ0FjK/
        WhVq35+qDeyE0yEJ3deeWODbqFMP7Y=; b=Q7ePOFj3/7tPmUxuMgXxdnvQ7/4fj
        JAgzD67K2gmxMYoJ1GqwR9PagUqX/TuxITlFlUdfpJGFcUHPX1zojm0XZUQ/RKnx
        HNE5K7Mkjo1bFCi9AsirmJ3HBT6l3wEnBMWYT3uGq536hVa/CxMwCMKhkn3oufKg
        K/uus53SvUVHkvjz1yJFBEuPfQ90oXIby9ihkMPWC+uSzM7pgaBTGQn2swzI3BJ0
        4T9t5jS5ksuT/cweoS+igkUCLhiJ1wFZa0LogyF0nQjWkQdgunVMK2TnY0QwZJom
        gNjm0faPZAKUOtBiNNQWmBvubwzpAb0wjCO4sjUaDluT+cWDkTi9/u9Tw==
X-ME-Sender: <xms:brsvZVr9yd5TQUpj3jrLvAVts-Kw6NAfmGg6hsDHVF8tiCbGY6Guhw>
    <xme:brsvZXrXjTgSo6PJmCd-JVlVSSHmHPs8SMr2KCFI7jDMdBQ54k22XdKkM0bvOF27j
    IbzXk390LpjdRxq_ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:brsvZSOz1OtgRyreC_4lW9UdFXif1FO7oKhOjLxECgaheeQE13wU5Q>
    <xmx:brsvZQ4kqUUFqZvDmTS2UFzleBkjtAFWtktpHUou5sDd-8MHywdTZw>
    <xmx:brsvZU6ylDwPz5tE2qpFeoQf1UwblXmiV84skraDpDynsFmgIHuFLQ>
    <xmx:brsvZf0o7aR0Y0i88mRF7tkiiJJRl_VNDma7URM4iqC3a0OYLpiuxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 377A0B60089; Wed, 18 Oct 2023 07:03:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <e8426444-0463-426a-892c-9493ba0cb543@app.fastmail.com>
In-Reply-To: <20231018100823.GH5392@unreal>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-4-saeed@kernel.org>
 <6fb88a6a-dd66-4368-8da9-596f384fe5bc@app.fastmail.com>
 <20231018100823.GH5392@unreal>
Date:   Wed, 18 Oct 2023 13:02:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Leon Romanovsky" <leonro@nvidia.com>
Cc:     "Saeed Mahameed" <saeed@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, "Jason Gunthorpe" <jgg@nvidia.com>,
        "Jiri Pirko" <jiri@nvidia.com>,
        "Saeed Mahameed" <saeedm@nvidia.com>
Subject: Re: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023, at 12:08, Leon Romanovsky wrote:
> On Wed, Oct 18, 2023 at 11:02:00AM +0200, Arnd Bergmann wrote:
>> On Wed, Oct 18, 2023, at 10:19, Saeed Mahameed wrote:
>> 
>> > Implement INFO ioctl to return the allocated UID and the capability flags
>> > and some other useful device information such as the underlying ConnectX
>> > device.
>> 
>> I'm commenting on the ABI here, ignoring everything for the moment.
>> 
>> >  static const struct file_operations mlx5ctl_fops = {
>> >  	.owner = THIS_MODULE,
>> >  	.open = mlx5ctl_open,
>> >  	.release = mlx5ctl_release,
>> > +	.unlocked_ioctl = mlx5ctl_ioctl,
>> >  };
>> 
>> There should be a .compat_ioctl entry as well, to allow 32-bit
>> tasks to use the same interface.
>
> Even for new code as well?
>
> Both kernel and userspace code is new, not released yet.

Yes, the main thing is that both x86 and arm support 32-bit
user space, and there are lots of users that use those in
containers and embedded systems. Even if it's unlikely to be
used in combination with your driver, there really isn't
much reason to be different from other drivers here.


>> I don't know what a UCTX UID is, but if this is related to
>> uid_t, it has to be 32 bit wide.
>
> UCTX UID is mlx5 hardware index, it is not uid_t.

Ok

>> 
>> > +	__u16 reserved1;
>> > +	__u32 uctx_cap; /* current process effective UCTX cap */
>> > +	__u32 dev_uctx_cap; /* device's UCTX capabilities */
>> > +	__u32 ucap; /* process user capability */
>> > +	__u32 reserved2[4];
>> > +};
>> 
>> If I'm counting right, this structure has a size of
>> 108 bytes but an alignment of 8 bytes, so you end up with
>> a 4-byte hole at the end, which introduces a risk of
>> leaking kernel data. Maybe give it an extra reserved word?
>
> I think that he needs to delete __u32 reserved2[4]; completely.

Removing the extra reserved words and the 'flags' is probably
best here, but you still need one 32-bit word to get to
a multiple of eight bytes to avoid the hole.

    Arnd
