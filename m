Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685D7B82DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbjJDO4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243132AbjJDO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016641A3;
        Wed,  4 Oct 2023 07:56:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 945C73200AB0;
        Wed,  4 Oct 2023 10:56:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Oct 2023 10:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696431375; x=1696517775; bh=E81iGMeNa+pNgKEkt1KkyiV7Sh5faYo5JX4
        pY/PFDew=; b=lpTrPM7sGkdmKIxZMmVxe6Eij5ocLE05ifOF7+fTaJoqwmaR9DC
        3omv1FtZIMcv0Q4KeKkXYfUh3bnHqwEZQO+4RmN8BWgd7HcQ8eNX8rsZOHD9UAJE
        5Hn4FGqRQOKxKDaIKZzDkcEJ+Y3OKSPUbTwFNRaA8ZTxSsjPFdUYwQpQ/II9nWrg
        i/hmeIqWrviPO0zwHsWOsnzoB5LBypT8kWLIHM6ehEqkrNGllczhwF9cq2MHywnT
        Lt6AKvnaN2gzA4Yb42pgSHlz6Xc3RjSHvbD4bTcywff1HGQ/SitCKQ/pmTUyoPku
        KI2Jg8VAv9JZvxBZqC0MqafNjKkerQn1lSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696431375; x=1696517775; bh=E81iGMeNa+pNgKEkt1KkyiV7Sh5faYo5JX4
        pY/PFDew=; b=Wv464ROziTRdG3i/7r2TG9cDUxlYV//R+b+h9c6Grk03YU5IwdG
        SegVxKIsosXLXyxdYoGXhwqTD770uMrOzo7duqeyK6cuf4wYoweNBpLrZLNKuLje
        I3Tb8CoikGOBgbPRPkLw7hZsqX9AhK4CwWnKLKzbGWbgXLG1PsG/8eCTvqWuXvIk
        i2ZBNaB6RrXUsUlta4RGR1NuA3I1KjTrQXoIPQMZGpGsnwvTo6epr0P5Ab9/vZLT
        hzmfVXyzgJvk/+/xEssxunwAAp/uTBGY04SbT6QFtxsCsBg22ggLRVpUtxx0Y+MC
        scAnPDpuLvInDjWK0kp7n6MpI2VZgNYNr9A==
X-ME-Sender: <xms:Dn0dZbFCaZchcZYIU3KBL-MUPPbpt77PJ4TTEDrskT02FC4uuwvj_g>
    <xme:Dn0dZYWH3kpKQGmY3LqLSg0QBYhqo09fYzkSmM34A6KnWRYeTYcPsoxb5hNHI69Nd
    49_KGewoj9W2DW2zMI>
X-ME-Received: <xmr:Dn0dZdKJfQrXebTf12W_DSd0Vwc_0bJiYEM-WllMkfpodLcvKSlW3BkJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkhffuvefvofhfjgesthhqredtredtjeenucfhrhhomhepfdfmohhn
    shhtrghnthhinhcuufhhvghlvghkhhhinhdfuceokhdrshhhvghlvghkhhhinhesfhhtmh
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeelhfdttdekudekffeuffektddvueeuffeh
    ieelffdufedvvefftdefffeggfelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgvkhhhihhnsehfthhmlhdrnhgvth
X-ME-Proxy: <xmx:Dn0dZZHGwa9BC2mZsTBLoU3G1blVi8VAOQkCP0v_t8y1mEHFxL_ouA>
    <xmx:Dn0dZRWW1_Vpe7KGYzez018EFqOVmDbXbJ6bFYECZPxrFQj4lFnRrQ>
    <xmx:Dn0dZUNh5G8WnO4rXlwRnRFzCqS5lUoZhQAUNbzonL9hqsI6STCuJw>
    <xmx:D30dZWUo1NrCSmYHmMyJ0DjZro079xydoLj-qbkY9lCgqqiogPVsyQ>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 10:56:12 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Oct 2023 17:56:09 +0300
Message-Id: <CVZQQCDA444R.KWA6OPEZRIBG@ftml.net>
From:   "Konstantin Shelekhin" <k.shelekhin@ftml.net>
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
Cc:     "Alice Ryhl" <aliceryhl@google.com>, <alex.gaynor@gmail.com>,
        <benno.lossin@proton.me>, <bjorn3_gh@protonmail.com>,
        <gary@garyguo.net>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>, <nmi@metaspace.dk>,
        <ojeda@kernel.org>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <tj@kernel.org>,
        <wedsonaf@gmail.com>, <yakoyoku@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.15.2.r182.g389d89a
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
 <20231003222947.374039-1-aliceryhl@google.com>
 <CVZLU74VWMKA.GQXYH7WUNPS4@pogg> <ZR144pugIJQRAFjj@boqun-archlinux>
In-Reply-To: <ZR144pugIJQRAFjj@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a problem until nvmet actually uses/switches to Rust, right?
> ;-) We can certainly improve the API when a real user needs something.
> Or you know someone is already working on this?

Nope, not at this moment. I have an itch to experiment with Rust and
iSCSI, but that's my personal toy without any plans to at least propose
it to the subsystem maintainers yet.

> All of your suggestions make senses to me, but because we don't have
> many users right now, it's actually hard to determine a "best" API. I
> like what we have right now because it's explicit: people won't need to
> learn much about procedure macros to understand how it works, and it
> also provides better opportunities for people who's yet not familiar
> with Rust to give some reviews. So starting with something relatively
> simple and verbose may not be a bad idea ;-)
>
> Again, I like your idea, we need to explore that direction, but one
> dragon at a time ;-)

Oh yeah, completely understand :)
