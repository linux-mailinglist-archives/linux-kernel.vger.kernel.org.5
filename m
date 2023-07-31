Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC776A4D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGaX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGaX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:28:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F590
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690846056; x=1691450856; i=efault@gmx.de;
 bh=2Br0UNIeQx4jGOtMFO6+6aow679ug/8pzGo46WVpO3M=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=S5xufcShWB7QBbEWbYFHUjyk5bayNf5dUjZSUgryK2N/sOlW/gTnxtQFaiJJr9b0apNyOT9
 lXwwJKT2roYhxutblor4uaL2DLLdjlpsgq4TQyV3I9y8z+fF1KVpBGIqKyab6FooFmM9qrIrI
 VDvwgenrCizBFYOZCsMKtWnhedidg4SFuX3pSLOTiJdehOEUvyyfCaYFo7uaeZldWmRkOdix2
 1iO0zwosXWXLP/XUwotwIh6FI28FzL6LQNo2277+2TtlNYS4o4jsPt51snXTDkUNjTlapv9gZ
 mfLWheubJjqgGxWaqW1ZhdWEDNXQmI7hHXU9VmYp0ypmy6y2p59A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer-2.fritz.box ([185.191.216.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1pon9i0xXC-015mgb; Tue, 01
 Aug 2023 01:27:36 +0200
Message-ID: <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
Subject: Re: arm64: perf test 26 rpi4 oops
From:   Mike Galbraith <efault@gmx.de>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, Will Deacon <will@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Date:   Tue, 01 Aug 2023 01:27:34 +0200
In-Reply-To: <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
         <20230728141852.GA21718@willie-the-truck>
         <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
         <20230731104340.GA24767@willie-the-truck>
         <20230731115207.GB24767@willie-the-truck>
         <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
         <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xwbf54OnizOtLbO9xE+7iRb6p7kVOq4hu3VRAFYweWoBZpkOf5s
 Lm49RTh6EG7wQ4/KFSubYOqKhvc+wIdKUb3uKA6CGCj83ZJLYlTTt7v8hUQTI08d6wOwqUQ
 XoO6JF3u7Kn80yKAPknlBxlfmx9K6CvThB0F/q0brw9KbWr6xFRcDVet2TtmozJyRYQLR/X
 ucg1rt8e/VgNHlSyrp28g==
UI-OutboundReport: notjunk:1;M01:P0:593Ady+9XfU=;DvqB7G05tb1/hcNFdIwDCzlFYES
 YT9ZrZtSPyw81MkJpeQWVQdIT3I0OfNqRsErhaoUMP+qoiOh7rcqO8ETiscbmZpswGqn/uFV/
 +DbzbANmgzlj26hbcexU5SUkb5z6eTDGZiC7p8JUHctl9jfEHhFXf+RswLP5caiSXMetcLm/T
 8d7vg2UtDadpcXASgQBo8ye+SY6nqAjjusx3JjngMhrs00Znj7e3nN21C2/3YzV+rBhTITQza
 1KdFoDg64uiBQSZNKoMDcK2NkDyugfTxzCrhL5pbivipVwxg7vZdhXCmw+F88k9W9/2GTJ51g
 0b4qOB3ZUdQelvMX6wirc5NNi5iX+25xX2ZGBoUdfAMtpaec+pkIqA8q/+q4XL9TYXTXcZ5SC
 BttpS85HMhaD/vb0/V9ELTDaqxcQNnvNdJRDG4hX0jwK/JO5vtpoq9CucaaSvnVkyy6Tvgh78
 bT3zn6uiyDyLIChNakkTjnqN8jilWdl8sv1g6bUIXDc4aJzA5WcjDTq/KOFukfUilB5+jJX6S
 Sylo2AMXEKTV0Q3LjWqW+kOe/aGLNdm7f2If/V8ktJPl81S8vkSZq3OEzYcaTUl2FodzPqyuV
 d1B0Lb9g8TEG4CeLo/Dg9MpMV+E5pAfGPXmgsCA64/WWWa8bsnXjKtboi7lKOeSPFq8p3hZJp
 +mD0JSU+DGEPvC4dIuuIMz3NfuauAnztyJvDb5nXM/5ewDHP1MlqBcGd9KH5EFiA0YpRlUisa
 EuUNkH7Ml+1nIceAcYLvsvk3Q3sSQWCyqthYHuyJaiAFrjCiLeBFJ/bjS8H2TDJCb6KfbKeMB
 7UuqiMkYDUS5BI08Mu+rSkeMlwz+cw0ZTNhZQSvVwpNjq+qgZn6DKsitbH+ZgjyVcvc696w1h
 3PPIZ6lRnylx3UO5pK2KzRcf6mtctPvNCNXZFmyHfwUKoPBPLNs2ClVSwIKGzgeiDL4KTscZ7
 HBwwlQpMy3BXouVMJM/O90o6LF0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-31 at 22:54 +0100, Lorenzo Stoakes wrote:
>
> Posted a fix at:-
>
> https://lore.kernel.org/all/20230731215021.70911-1-lstoakes@gmail.com/
>
> Please give that a go and indicate whether that resolves the issue.

Yup, that fixed the oops issue.

	-Mike
