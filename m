Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74831771CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjHGJMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHGJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:12:36 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75674E6C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:12:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB2665C00C0;
        Mon,  7 Aug 2023 05:12:33 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Mon, 07 Aug 2023 05:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691399553; x=1691485953; bh=y3DPVjkaUxmqO62aQ4XQSfaxDrnmEMdPiEB
        qy9V57yg=; b=IxYbbtvo/JaymIlnXE7lQ3CiNTPRz/wOKkq6mR6l2Q+IR0aN8Y2
        wfuHeFr6UmzUWtArndSqggkRMKp+y7CDcQLPVLjXG/i+Owf77OoQu+RweFTZwV2+
        Irynuu+iSfkhIJbBrBvPwVFR6C0waicxUWHps/vKvQ7uiR41e5UuH5tN7lS1z4iE
        uT4spH7u9T950VStlfZnJAAO/TOPqLkT/3hjavsrrFIzqEh2zl97CKLFf7RE23KT
        0kKE1Qs87UpWud4wy+SfeuBgUQwVupdidCZ/L2D54Qq0luwvRDM5754/+jZYuAU+
        qydfu8SCpKmAmUoA2rPVAz9HEzYcpxxb9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691399553; x=1691485953; bh=y3DPVjkaUxmqO62aQ4XQSfaxDrnmEMdPiEB
        qy9V57yg=; b=ysGGkc2TZ3T//tTg2gphUgG2pgxOYDGTCWJwQkNn8u9MTR1FkgR
        PVoHVIhlqXFe63RhtXO9CF+Dsx4g4upHdfqTL2VOWTYzsSULiYNOx6pBuszO9zz3
        KWSX4ZPJgh+TNEF/wBpsYx8GmyXWSYtfdmBj11UKX6SNkCGxGG7ESHO4g0x+dF/a
        w+8xC0tEebg82Hp9GogsphdD5w3ai9oMyQy/u8exxq+H0Jnl7UdW2d4Ze6v1pu10
        v93+1o74JnvsaDlFbl+FaI4Mju8OEEqn2/8kg8epZ17vDE2I3F29Cc3SFu0IASRd
        y51cVB1FmADh4apb/SL1/x4FVw6NQZatrLw==
X-ME-Sender: <xms:gbXQZBCVYod6MuJDDYymSKZmbtKNoGIJIOb891JrDzev2uh1xet7jA>
    <xme:gbXQZPjzm8mfMXV4PN8Hf6gjpE43OManTyuEAOTqXvN3tOA0vBVzPFfimMyaPiuvF
    zICBIFcbLP0p9DROUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfffgr
    vhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvggruggrhhgvrggurdgvuh
    eqnecuggftrfgrthhtvghrnhepjeeguedtueeftdejffdvgffhvddvteetjeeftdeiffek
    udffieehieejhedvkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:gbXQZMkImOQYhc4SE-6TpMdcsYkyO2kr8iBrPYp1hktfgOYtRdrPrg>
    <xmx:gbXQZLy_z5hSWLK9MMCR6WSkfjzx8ewxFhNk22oD5GIWxJUDLj3miA>
    <xmx:gbXQZGRPS7xyw0wEceI7CK_mhfeXyQCtmSb_doDo82WpgdOFjPvKZg>
    <xmx:gbXQZEe-t-FQi1fA_yaXPEy7RDdCKs-pA-gUSMKqjYtjlBv2ssCzUg>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E0BF1700089; Mon,  7 Aug 2023 05:12:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <24357f20-4354-4b44-b3f7-4cb29dcfb8b4@app.fastmail.com>
In-Reply-To: <CAJqdLroQE1sU2uOG018Ezyome1sQb89c_mdSdvOCpM7=XNt+xg@mail.gmail.com>
References: <20230807085203.819772-1-david@readahead.eu>
 <CAJqdLroQE1sU2uOG018Ezyome1sQb89c_mdSdvOCpM7=XNt+xg@mail.gmail.com>
Date:   Mon, 07 Aug 2023 11:12:11 +0200
From:   "David Rheinsberg" <david@readahead.eu>
To:     "Alexander Mikhalitsyn" <alexander@mihalicyn.com>
Cc:     linux-kernel@vger.kernel.org,
        "Christian Brauner" <brauner@kernel.org>,
        "Jan Kara" <jack@suse.cz>, "Kees Cook" <keescook@chromium.org>,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Aug 7, 2023, at 11:01 AM, Alexander Mikhalitsyn wrote:
> On Mon, Aug 7, 2023 at 10:52=E2=80=AFAM David Rheinsberg <david@readah=
ead.eu> wrote:
[...]
>>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file *=
*ret)
>>  {
>> -       if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
>> +       if (!pid)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Non thread-group leaders cannot have pidfds, but we allow =
them for
>> +        * reaped thread-group leaders.
>> +        */
>> +       if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDT=
YPE_TGID))
>>                 return -EINVAL;
>
> Hi David!
>
> As far as I understand, __unhash_process is always called with a
> tasklist_lock held for writing.
> Don't we need to take tasklist_lock for reading here to guarantee
> consistency between
> pid_has_task(pid, PIDTYPE_PID) and pid_has_task(pid, PIDTYPE_TGID)
> return values?

You mean PIDTYPE_TGID being cleared before PIDTYPE_PID (at least from th=
e perspective of the unlocked reader)? I don't think it is a compatibili=
ty issue, because the same issue existed before the patch. But it might =
indeed be required to avoid spurious EINVAL _while_ the target process i=
s reaped.

It would be unfortunate if we need that. Because it is really not requir=
ed for AF_UNIX or fanotify (they guarantee that they always deal with TG=
IDs). So maybe the correct call is to just drop pidfd_prepare() and alwa=
ys use __pidfd_prepare()? So far the safety-measures of pidfd_prepare() =
introduced two races I already mentioned in the commit-message. So maybe=
 it is just better to document that the caller of __pidfd_prepare() need=
s to ensure the source is/was a TGID?

Thanks
David
