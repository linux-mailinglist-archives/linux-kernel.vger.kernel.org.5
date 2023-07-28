Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB07665D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjG1Hz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjG1Hz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:55:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987E2173F;
        Fri, 28 Jul 2023 00:55:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 810B05C00AF;
        Fri, 28 Jul 2023 03:55:19 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 28 Jul 2023 03:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690530919; x=1690617319; bh=XVoKzIZsKS3ZCP8rUUytIx3YBhBabFVdsfQ
        LR4c+1Us=; b=ZwgwJ+BxR5QMmxbkfmsXE5rzJHGLOUN73LJwpukRXw4W7jWzVdk
        MCAZcTiDk5OnV3OaiQAx5lHhDUPdl6yHDHlz4O1vmy7prHo3KnppZ3x4aTTE5SIy
        jA+UFZKZwfukWEN5iAMKMDgmaYK6j8so/delo6E5SbAwMfenNwVNLsl0IrR615Eh
        Mw2uP4OGpHlO+bdcBJ9VlP6D6PgElYTKccAUQe87r8EzeRR77PPqlQhq+6mSULBn
        pEGNWE9svcYY+ykdn7Vr/63MmmD5gp67NsHE7HJPbT14AIGF2rp+mdkPbvsw/OVm
        zMHkcAw1FrUi2QA/3K7i/AKDAT5W5k7AfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690530919; x=1690617319; bh=XVoKzIZsKS3ZCP8rUUytIx3YBhBabFVdsfQ
        LR4c+1Us=; b=ohOYPS3kWkf/3ikd4qcOvqZgIwrcayBI4xEtM66/VY1OuJuIrm1
        95rjTz+hySiLj1QotTNFzuUwvnH5QoLh2h9LViYJOWN+ATMpy/IU5aGxTtceBwDm
        nfR1z179oBC+hKJjEtvF9KezlU5TJMCIRlCqT1YOlO8A/aE0M6obznfF5FE1CGaB
        ieud7VpLjGe+ZksRsaaoCPYR8u6uZ6Ep9DKqZfBdktyXkbZTBnE2G1ZPFs7AmREI
        cEuPV2BVFkH0ddCnpBjWLejP7IjqrQwO9q9X1jS6ZyL0VcF4EOQMNP39FLjOSooa
        0T8WCd20iq1IOhEfWUc2kLEZoztTg49CaJQ==
X-ME-Sender: <xms:Z3TDZNEIPgKFOrprLtEZB-UU3Ea6dGK0BzszKSsJSy4fOTgo_Zl8Ag>
    <xme:Z3TDZCWj91Z2iTRF7HBWfyCfA0zumGqzTzVeZ8quplnaKBXG7EqrAzOz5U5rmt7GS
    yqRRcF9vgmmHyR7H80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieehgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpeejgeeutdeufedtjeffvdfghfdvvdetteejfedtieff
    keduffeiheeijeehvdekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegurghvihgusehrvggruggrhhgvrggurdgvuh
X-ME-Proxy: <xmx:Z3TDZPIMgPdkJQRW67ZAX9_05wDRPcyBPuFAhX9ep19GvLcMs43IFg>
    <xmx:Z3TDZDFbIn0Dafsel2URN60upAIhrBKX07ZWcWunSzHLsiVeEqQj_w>
    <xmx:Z3TDZDWe_vBaICHWY674A1cOnc6Oni5doZpGotE8I3Z5eWZO1n8QXQ>
    <xmx:Z3TDZJe1-oFCoerzhx8cIi3vMNFlyf4FARLtfUTvS72kIaPnkzktEA>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28A0C1700089; Fri, 28 Jul 2023 03:55:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <fb464cbf-04c4-4346-a96b-e0b2ab804e16@app.fastmail.com>
In-Reply-To: <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
References: <20230714114753.170814-1-david@readahead.eu>
 <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
Date:   Fri, 28 Jul 2023 09:54:57 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Jeff Xu" <jeffxu@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Daniel Verkamp" <dverkamp@chromium.org>, linux-mm@kvack.org,
        "Peter Xu" <peterx@redhat.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jul 18, 2023, at 9:03 PM, Jeff Xu wrote:
> Hi David
>
> Thanks email and patch for discussion.
>
> On Fri, Jul 14, 2023 at 4:48=E2=80=AFAM David Rheinsberg <david@readah=
ead.eu> wrote:
>>
>> Add a new flag for memfd_create() called MFD_NOEXEC, which has the
>> opposite effect as MFD_EXEC (i.e., it strips the executable bits from
>> the inode file mode).
>>
> I previously thought about having the symmetric flags, such as
> MFD_NOEXEC/MFD_EXEC/MFD_NOEXEC_SEAL/MFD_EXEC_SEAL, but decided against
> it. The app shall decide beforehand what the memfd is created for, if
> it is no-executable, then it should be sealed, such that it can't be
> chmod to enable "X" bit.

My point is, an application might decide to *not* seal a property, becau=
se it knows it has to change it later on. But it might still want to dis=
able the executable bit initially, so to avoid having executable pages a=
round that can be exploited.

>> The default mode for memfd_create() has historically been to use 0777=
 as
>> file modes. The new `MFD_EXEC` flag has now made this explicit, paving
>> the way to reduce the default to 0666 and thus dropping the executable
>> bits for security reasons. Additionally, the `MFD_NOEXEC_SEAL` flag h=
as
>> been added which allows this without changing the default right now.
>>
>> Unfortunately, `MFD_NOEXEC_SEAL` enforces `MFD_ALLOW_SEALING` and
>> `F_SEAL_EXEC`, with no alternatives available. This leads to multiple
>> issues:
>>
>>  * Applications that do not want to allow sealing either have to use
>>    `MFD_EXEC` (which we don't want, unless they actually need the
>>    executable bits), or they must add `F_SEAL_SEAL` immediately on
>>    return of memfd_create(2) with `MFD_NOEXEC_SEAL`, since this
>>    implicitly enables sealing.
>>
>>    Note that we explicitly added `MFD_ALLOW_SEALING` when creating
>>    memfd_create(2), because enabling seals on existing users of shmem
>>    without them knowing about it can easily introduce DoS scenarios.
>
> The application that doesn't want MFD_NOEXEC_SEAL can use MFD_EXEC,
> the kernel won't add MFD_ALLOW_SEALING implicitly. MFD_EXEC makes the
> kernel behave the same as before, this is also  why sysctl
> vm.memfd_noexec=3D0 can work seamlessly.
>
>>   It
>>    is unclear why `MFD_NOEXEC_SEAL` was designed to enable seals, and
>>    this is especially dangerous with `MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL`
>>    set via sysctl, since it will silently enable sealing on every mem=
fd
>>    created.
>>
> Without sealing, chmod(2) can modify the mfd to be executable, that is
> the consideration that MFD_NOEXEC is not provided as an option.
> Indeed, current design is "biased" towards promoting MFD_NOEXEC_SEAL
> as the safest approach, and try to avoid the pitfall that dev
> accidently uses "MFD_NOEXEC" without realizing it can still be
> chmod().

I think I didn't get my point across. Imagine an application that does *=
NOT* use sealing, but uses memfds. This application shares memfds with u=
ntrusted clients, and does this in a safe way (SIGBUS protected). Everyt=
hing works fine, unless someone decides to enable `vm.memfd_noexec=3D2`.=
 Suddenly, the memfd will have sealing enabled *without* the application=
 ever requesting this. Now any untrusted client that got the memfd can a=
dd seals to the memfd, even though the creator of the memfd did not enab=
le sealing. This client can now seal WRITES on the memfd, even though it=
 really should not be able to do that.

(This is not an hypothetical setup, we have such setups for data sharing=
 already)

Thus, setting the security-option `memfd_noexec` *breaks* applications, =
because it enables sealing. If `MFD_NOEXEC_SEAL` would *not* imply `MFD_=
ALLOW_SEALING`, this would not be an issue. IOW, why does =C2=B4MFD_NOEX=
EC_SEAL` clear `F_SEAL_SEAL` even if `MFD_ALLOW_SEALING` is not set?

>>  * Applications that do not want `MFD_EXEC`, but rely on
>>    `F_GET_SEALS` to *NOT* return `F_SEAL_EXEC` have no way of achievi=
ng
>>    this other than using `MFD_EXEC` and clearing the executable bits
>>    manually via fchmod(2). Using `MFD_NOEXEC_SEAL` will set
>>    `F_SEAL_EXEC` and thus break existing code that hard-codes the
>>    seal-set.
>>
>>    This is already an issue when sending log-memfds to systemd-journa=
ld
>>    today, which verifies the seal-set of the received FD and fails if
>>    unknown seals are set. Hence, you have to use `MFD_EXEC` when
>>    creating memfds for this purpose, even though you really do not ne=
ed
>>    the executable bits set.
>>
>>  * Applications that want to enable the executable bit later on,
>>    currently have no way to create the memfd without it. They have to
>>    clear the bits immediately after creating it via fchmod(2), or just
>>    leave them set.
>>
> Is it OK to do what you want in two steps ? What is the concern there =
? i.e.
> memfd_create(MFD_EXEC), then chmod to remove the "X" bit.
>
> I imagine this is probably already what the application does for
> creating no-executable mfd before my patch, i.e.:
> memfd_create(), then chmod() to remove "X" to remove "X" bit.

Yes, correct, this is not a technical issue, but rather an API issue. I =
don't think most memfd-users are aware that their inode has the executab=
le bit set, and they likely don't want it. But for backwards-compatibili=
ty reasons (as noted above), they cannot use `MFD_NOEXEC_SEAL`. Hence, w=
e have to make them explicitly request an executable memfd via `MFD_EXEC=
` now, even though they clearly do not want this. And then we have to ad=
d code to drop the executable immediately afterwards.

It don't understand why we don't add out `MFD_NOEXEC` and thus make it a=
 lot easier to patch existing applications? And we make it explicit that=
 these applications don't care for the executable-bit, rather than forci=
ng them to request the executable bit just to drop it immediately.

The downside of `MFD_NOEXEC` is that it might be picked over `MFD_NOEXEC=
_SEAL` by uneducated users, thus reduce security. But right now, the alt=
ernative is that existing code picks `MFD_EXEC` instead and never clears=
 the executable bit, because it is a hassle to do so.

Or is there another reason *not* to include `MFD_NOEXEC`? I am not sure =
I understand fully why you fight it so vehemently?

Thanks
David
