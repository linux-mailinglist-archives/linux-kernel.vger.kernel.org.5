Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F176C7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjHBIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjHBIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:00:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F149D6;
        Wed,  2 Aug 2023 00:58:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3C0CA320069B;
        Wed,  2 Aug 2023 03:58:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 03:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690963095; x=1691049495; bh=hgNvOgWnhU72CHJJjI7j1ZEp7Bx+lB7eT5b
        N2SgTrYg=; b=bXWTfWLTwbScOLXbA5h+G+00oArw+EjOc3OBeYXRWBQz+AMZJ7F
        Q9ownNe8/H85vcjuzeZSAsTmoEns2nJgWu2lsl+KHKVju/5XkZtiST181OHgayHt
        e9OiLwprgMy4K52qw/DukiweP4q/LMDCaHmlAJMdtE0Q5YyksqkDK3Xe1muQL5oQ
        eCXGHIJgm8gZZ6oFrKU+LcjxupqhmZI49h0ndRsGn8SIZxSz5RHbWe7pNbRrjTzC
        YoQgmzLyDQGCtZSegezKxiBKX0Rj6rfe7A/+bBW5mYKFHXEwMqRw6Im4aGSGzbh/
        1eVswehFD+5d4zrUSoNqZFHPbF/elmizWkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690963095; x=1691049495; bh=hgNvOgWnhU72CHJJjI7j1ZEp7Bx+lB7eT5b
        N2SgTrYg=; b=Hk7lbC2fBtvFOp3I75OKZL5c17qW1+y/l6GuZ1vxtklo75diNPR
        R8R53NOH14gRnVPSAkBzLFj67tbO6/oKXEJlPTuJeEcc65HijmZ7FBgXH6WWeokc
        MkTqOt+WKNQUYuyJ11ZcWzQsTHtxnPNeedJNie+KEpQKrOpXU3H5+6g3VlqjI6k8
        HO5ZE2DVQ+rlgtGL3xd7JLomVTckch8kZo1IN4PVnvXiPL9g2iDIS046ncPXe5/j
        LyWou9knXmvB56f3EU17g2ihrfR0cmJb5xFVJPI1mJ8+PusaOL6+N+djQg9bJtAw
        WRXyGwNm4YJtRmqQfsKz0So196D5gSW+sgQ==
X-ME-Sender: <xms:lwzKZAkDVOR7MxDysayQSIaBGe-nuq3WpJfzCnE9FkF79rZLDqTwBw>
    <xme:lwzKZP18wZRiCEjbLLTovN5rJGpWqro4a74U8G4i2KBLlcYaJ3xn9TMeSA4U54F09
    A9H12-IqXcouglgtb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpeejgeeutdeufedtjeffvdfghfdvvdetteejfedtieff
    keduffeiheeijeehvdekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegurghvihgusehrvggruggrhhgvrggurdgvuh
X-ME-Proxy: <xmx:lwzKZOrdScOs-0-JktXEeeBVyWR5lfDZfGAA6b-J6o5Ho0ICWm4hvw>
    <xmx:lwzKZMkkb0iYQeAxiHr-91QMnUPU_EhntHCSeQHxPloBEHLu3SgmeQ>
    <xmx:lwzKZO0D7yXglCMylD-H3LIj9lEtRZi0975ysQLik3L-m_OwrhNHJQ>
    <xmx:lwzKZIo83AyeLK_fFkz7J06AE1Gs-GB2XI_YIhkvMRnD3fsg-BJhcw>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2C38B1700089; Wed,  2 Aug 2023 03:58:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <dadfd8d3-fe83-4aee-b8aa-3b31d4408f66@app.fastmail.com>
In-Reply-To: <CABi2SkUOxngcDwRDtFFD2Uef=BUXVN08dMYhmpuS_b1xC39L7g@mail.gmail.com>
References: <20230714114753.170814-1-david@readahead.eu>
 <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
 <fb464cbf-04c4-4346-a96b-e0b2ab804e16@app.fastmail.com>
 <CABi2SkUOxngcDwRDtFFD2Uef=BUXVN08dMYhmpuS_b1xC39L7g@mail.gmail.com>
Date:   Wed, 02 Aug 2023 09:56:42 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Jeff Xu" <jeffxu@chromium.org>
Cc:     "Jeff Xu" <jeffxu@google.com>, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Daniel Verkamp" <dverkamp@chromium.org>, linux-mm@kvack.org,
        "Peter Xu" <peterx@redhat.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff!

On Tue, Aug 1, 2023, at 9:24 PM, Jeff Xu wrote:
>> My point is, an application might decide to *not* seal a property, be=
cause it knows it has to change it later on. But it might still want to =
disable the executable bit initially, so to avoid having executable page=
s around that can be exploited.
>>
>
> I understand that.
> My argument was this application can do this in two steps, as in my
> previous email:
> 1> memfd_create(MFD_EXEC)
> 2> chmod
>
> Two system calls back to back isn't too terrible,  and I know this
> might seem to be not optimized for your user case, I will explain it
> later, please read on.

Yes, I agree that MFD_NOEXEC would be rather simple to imitate. So this =
is mostly a discussion about the intention and side-effects of this work=
around, which is also likely why we haven't found an agreement, yet.

[...]
>> I think I didn't get my point across. Imagine an application that doe=
s *NOT* use sealing, but uses memfds. This application shares memfds wit=
h untrusted clients, and does this in a safe way (SIGBUS protected). Eve=
rything works fine, unless someone decides to enable `vm.memfd_noexec=3D=
2`. Suddenly, the memfd will have sealing enabled *without* the applicat=
ion ever requesting this. Now any untrusted client that got the memfd ca=
n add seals to the memfd, even though the creator of the memfd did not e=
nable sealing. This client can now seal WRITES on the memfd, even though=
 it really should not be able to do that.
>>
>> (This is not an hypothetical setup, we have such setups for data shar=
ing already)
>
> Thanks, this helps me understand your point better.
>
> I'm not convinced that sysctl needs to consider the threat model of
> "someone" changing and breaking an application.  If we follow that
> threat model, there are a lot of other sysctls to worry about.
>
> Also, in the system that you described, if memfd is handled to an
> untrusted process, not only "sealing"  can cause damage, but also
> chmod, arbitrary rw,  imo the right approach is to harden the process
> or mechanism of passing the memfd.

No. The model I describe is carefully designed to hand out file-descript=
ors to inodes that the clients have *no* access to. They cannot run fchm=
od(2), unlink(2), etc. All they can do is operate on the open file. And =
all access to this shared file is properly guarded against possible dama=
ge the other concurrent clients can do. The entire model is already hard=
ened against malicious actors.

With the new sysctl, a new attack-vector is introduced, which was not po=
ssible before.

I was *explicitly* told to add `MFD_ALLOW_SEALING` for that exact reason=
 when introducing memfd_create(2). So I am a bit baffled why it is now o=
k to enable sealing behind the users back.

I agree that the new sysctl is a root-only option. But I fail to see *wh=
y* it implies `MFD_ALLOW_SEALING`? This behavior is not documented nor i=
s it explained in the original commit-messages, nor mentioned *anywhere*.

>> Thus, setting the security-option `memfd_noexec` *breaks* application=
s, because it enables sealing. If `MFD_NOEXEC_SEAL` would *not* imply `M=
FD_ALLOW_SEALING`, this would not be an issue. IOW, why does =C2=B4MFD_N=
OEXEC_SEAL` clear `F_SEAL_SEAL` even if `MFD_ALLOW_SEALING` is not set?
>>
>
> If MFD_NOEXEC_SEAL is not desired, then it should not be used to
> overwrite memfd_create() in this system.
>
> For the question of why the sysctl adding a seal without application
> setting it , the rationale here is, as summary of previous/this
> emails:

I still think we are not talking about the same thing. I completely unde=
rstand why you add the seal! I am just questioning why you *CLEAR* `F_SE=
AL_SEAL`? That is, why do you enable `MFD_ALLOW_SEALING` without the use=
r requesting it? You could just set `F_SEAL_EXEC` without clearing `F_SE=
AL_SEAL`. And then require `MFD_ALLOW_SEALING` on top to clear `F_SEAL_S=
EAL`.

[...]
>> The downside of `MFD_NOEXEC` is that it might be picked over `MFD_NOE=
XEC_SEAL` by uneducated users, thus reducing security. But right now, th=
e alternative is that existing code picks `MFD_EXEC` instead and never c=
lears the executable bit, because it is a hassle to do so.
>>
>
> Yes. This is the downside I was thinking about.
>
> I lean to believe the kernel API shouldn't be feature rich, it could
> be simple, optimized towards the majority of user cases, and ideally,
> is self-explained without devs to look through documentation. For
> example, if I had to choose one to implement between MFD_NOEXEC and
> MFD_NOEXEC_SEAL, I would choose MFD_NOEXEC_SEAL because it should be
> what most users care about.

Well, if we were to go back, we would make MFD_NOEXEC(_SEAL) the default=
 and just add `MFD_EXEC` :)

>> Or is there another reason *not* to include `MFD_NOEXEC`? I am not su=
re I understand fully why you fight it so vehemently?
>>
>
> I wouldn't add it myself, I hope to convince you not to :-).
> If you still think it is beneficial to add MFD_NOEXEC (saving one
> chmod call and making it easy to use), I wouldn't feel bad about that.
> I would suggest going with documentation to help devs to choose
> between those two, i.e. recommend MFD_NOEXEC_SEAL in most cases.

Any application that cannot use `F_SEAL_EXEC` (e.g., because its peers v=
erify for historic reasons that the seal is not set) now has to do an ex=
tra dance to get the "safer" behavior, rather than getting the "safer" b=
ehavior by default. That is, we make it easier to get the unsafe behavio=
r than to get the safe behavior (in this particular scenario).

Without `MFD_NOEXEC`, it is easier to end up with a 0777 memfd than not.=
 I want the application that desires `S_IXUSR` to jump through hoops, no=
t the application that does *not* require it.

In other words, I would prefer `MFD_ALLOW_EXEC`, which requires fchmod(2=
)` to set `S_IXUSR`, rather than requiring a call to fchmod(2) to clear =
it for everyone that does not need it.

Thanks
David
