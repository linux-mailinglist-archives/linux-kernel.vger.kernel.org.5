Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858137B7263
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbjJCUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjJCUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:13:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C6A7;
        Tue,  3 Oct 2023 13:13:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C68EE5C02DC;
        Tue,  3 Oct 2023 16:13:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 03 Oct 2023 16:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1696364008; x=
        1696450408; bh=WsB9L9DWS7tkowlV7TtWLRR1ydB8yDugfdaCwbWVulY=; b=b
        NKxAHlRC1f33oSkY8zGi9xwdwB+NVVDrI/qhLKFlPkCuWSzKs+MFpT/eGHHDFb7O
        VHwyCCTykZzB2aVgb745gL7MxNDI/U0ko4MLXYcVFwpHI6nmRNlunkPUGU2TkVLo
        0NxL/BEFzjJyUbBf2u4ComavzV7p7Gs/02e/Qc65b6L8CetXdUTKxeTuKBFoslzf
        8D7F52dv5RrctHeNMqA1a7UJDzD0gJoh7qQP99Qntnc1Cqty99SA60y6SuUp1/Rk
        0sc39Vx7J871TqC1wZrMNW1In9+k+GYlxgZKRIRtjx5XRaGM/Y/4GjwIHeG8ok42
        NiWtfnzEOqyNCyZ3IZ1qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1696364008; x=
        1696450408; bh=WsB9L9DWS7tkowlV7TtWLRR1ydB8yDugfdaCwbWVulY=; b=D
        GYb53HFuqWlBADhwaIRw5AgrR9HOXZCBRa/A0cybXWMIW1847XixBMRK+A72DVWg
        f5KDXmB7StSewnXwTCpHeLI9WpeXjz/PEP4DlQs0BXcEueYpVum+o6zK2RW8pKIh
        JLoMQ09tAgacggV/uNNZWJH57bTBvVcPeJw9Y2y1piJgrYILF7KNoJX+6t4qPLLY
        qSCkBqhDjcmkAiAXWqBEsSQLKNWNtC/vO7kl5ywlDmNVFhI+jX7LRCRlHZCikaJe
        tuIN2Z+tARu4Z6XawkJfkh6xClB9xiypQsp2CqOSYvOj5mN/qrmymNdPsY/g6KUB
        xrwA+ciGEwilDNJHLcQKw==
X-ME-Sender: <xms:6HUcZf5riEfriOqXPEosTd4e8sRHmKC8vVNAA31N0-fDRb4Y-YYa1Q>
    <xme:6HUcZU5LOiBFdznF3yHfzHGmgF6p1jJP5lHWp7BjVrC4MWkGN4rQVLzEKNWgWAvsf
    -zTsPKWAG7VMpWYlzk>
X-ME-Received: <xmr:6HUcZWd8wh_ShxRKTp5c_75Gw68GRx9QgUB97sCthkz7XWiDssLPgKfz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepggfgtgffufevvffhkffojgesthhqre
    dtredtjeenucfhrhhomhepfdfmohhnshhtrghnthhinhcuufhhvghlvghkhhhinhdfuceo
    khdrshhhvghlvghkhhhinhesfhhtmhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeejff
    ekjedujeekteetveeiveegvdfhieevudegtdeileduudekleetfeelveehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgvkh
    hhihhnsehfthhmlhdrnhgvth
X-ME-Proxy: <xmx:6HUcZQLuaofnC19tpGi4EXyZVcPMyHHmS-gfJz2Fkq1A605b2niCBg>
    <xmx:6HUcZTLneBxVhuavGqlZAk_CIYuv_l7nXQnjTFRu1iHdW3RHoHwGHA>
    <xmx:6HUcZZz4L77_GSJoHS-BA-XWBCmBHvueP8ro-rRU7MxdGqXU6_-z2w>
    <xmx:6HUcZSYYUeeKoXfb06GT_KKwuAm-9PB_SHjlWajkEAYAyh1A4dI3bQ>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 16:13:26 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 23:13:25 +0300
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
Cc:     <alex.gaynor@gmail.com>, <benno.lossin@proton.me>,
        <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
        <gary@garyguo.net>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>, <nmi@metaspace.dk>,
        <ojeda@kernel.org>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <tj@kernel.org>,
        <wedsonaf@gmail.com>, <yakoyoku@gmail.com>
To:     <aliceryhl@google.com>
From:   "Konstantin Shelekhin" <k.shelekhin@ftml.net>
Message-Id: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
X-Mailer: aerc 0.15.2.r131.ga5d6a70
In-Reply-To: <20230828104807.1581592-8-aliceryhl@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+//! #[pin_data]
+//! struct MyStruct {
+//!     value: i32,
+//!     #[pin]
+//!     work: Work<MyStruct>,
+//! }
+//!
+//! impl_has_work! {
+//!     impl HasWork<Self> for MyStruct { self.work }
+//! }
+//!
+//! impl MyStruct {
+//!     fn new(value: i32) -> Result<Arc<Self>> {
+//!         Arc::pin_init(pin_init!(MyStruct {
+//!             value,
+//!             work <- new_work!("MyStruct::work"),
+//!         }))
+//!     }
+//! }
+//!
+//! impl WorkItem for MyStruct {
+//!     type Pointer =3D Arc<MyStruct>;
+//!
+//!     fn run(this: Arc<MyStruct>) {
+//!         pr_info!("The value is: {}", this.value);
+//!     }
+//! }
+//!
+//! /// This method will enqueue the struct for execution on the system wo=
rkqueue, where its value
+//! /// will be printed.
+//! fn print_later(val: Arc<MyStruct>) {
+//!     let _ =3D workqueue::system().enqueue(val);
+//! }

I understand that this is highly opionated, but is it possible to make
the initialization less verbose?

Because the C version looks much, much cleaner and easier to grasp:

    struct my_struct {
        i32 value;
        struct work_struct work;
    };

    void log_value(struct work_struct *work)
    {
        struct my_struct *s =3D container_of(work, struct my_struct, work);
        pr_info("The value is: %d\n", s->value);
    }

    void print_later(struct my_struct &s)
    {
        INIT_WORK(&s->work, log_value);
        schedule_work(&s->work);
    }
