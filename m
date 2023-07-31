Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D183A769AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGaPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:39:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E97D8;
        Mon, 31 Jul 2023 08:39:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 991E85C0115;
        Mon, 31 Jul 2023 11:39:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 11:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690817960; x=1690904360; bh=3sigVTCHFGVp6funFXn9uMuJRWZKuRcAdPw
        XsFRL79U=; b=euvsBWRLUcgYzXOv1gUR1dh6GsWM/6vgxNlLxFaWlFVPxBRK+Y5
        vh2ASC2d2M/80LiY9f/xB9tqCii5mb6xmIGqOlzvlZCyyS8uJImpF5z909mG2RvD
        4Yb+5faz+AGFAn05IIwkGQD7+pVTbO2z23gqA/MTSyFWSVZdKi+9YJRf4LS9aKIu
        Xpvw8IbIZpVOOGCQH5P3/53IQc8VH5CtCe9mpcAhvRejuVevHS0VArXpmQPNuSeh
        f7gjGEncdVNwVhUpoFueY3kBYVbknAaCyfbhtTV7AC8+EZ9s7Brhxj87YG/b3SoC
        yI/aNBgtMLYUk4azI6ida25VQTdv6523X+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690817960; x=1690904360; bh=3sigVTCHFGVp6funFXn9uMuJRWZKuRcAdPw
        XsFRL79U=; b=HyWGJiXZ+MNH2y46FO1+cigNi91kIU4365wFjuNjNMtMGeumAf1
        K5gjGXK6lndpZUxYot6IDZ7jH/k8dvYOHqCTqddLCImU0CPjNdShIOnGfVXgYuWE
        mR0HQiceO2GsvtfsGm1QS7ah7G8hsVL7NerNtH7ayETLiic3ADu7voN97pzk1Y0c
        phGWV+tPcrLVc5xnRspm7x3L+feofd19kq9lorOdzfWPjyM8V1fCH3rclBMq7TRq
        bEyojzgHEeDYtpDjReh1Eq4HJLnUOHJTgxTzrDpDbXdnpZ/Xt8w6xqP12zhlViU7
        A4+Vsd7mM9G3PsXmUtlKOwTpZVby9pY2PlA==
X-ME-Sender: <xms:qNXHZI4kvdwJPdlvXkp6H3EQRNgSQRMfQwrECk61YoaEkL39jzEGCg>
    <xme:qNXHZJ5APgqGiWebqlTjRr5x-ONt_2HHrZ6kZo9uAftnF65zgwx_pwIQEy15SQMCM
    hZlQQOX2w0eC9nAGy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qNXHZHfPl9ekhjjXlnW9-PY2Vr_lT25YYa6_jWHQwqlmUh0wpoTnNA>
    <xmx:qNXHZNKrn-gD26nLbRak_Lkq-0wnU5XAIGA8ZYtqqnzSUG-g5GsA1g>
    <xmx:qNXHZMKYNj4PfS7OO6NihWOZZ-ib3udGBHBpWZpglOXtHDHW1AHxxg>
    <xmx:qNXHZL-DxcazecXQPWBgxihOE1ZM_w2xR59y9f0WEngbh0VgUSL3Xw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0CAB4B60089; Mon, 31 Jul 2023 11:39:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <c7526061-2f4e-4843-825c-98d9494af625@app.fastmail.com>
In-Reply-To: <7C51AA15-DEBE-486B-9788-F84B260F8880@gmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
 <20230731110239.107086-3-clamor95@gmail.com>
 <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com>
 <7C51AA15-DEBE-486B-9788-F84B260F8880@gmail.com>
Date:   Mon, 31 Jul 2023 17:38:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Svyatoslav Ryhel" <clamor95@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samu Onkalo" <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] misc: adps990x: convert to OF
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 16:58, Svyatoslav Ryhel wrote:
> 31 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80. 16:18:16 GMT+03:00, Arn=
d Bergmann <arnd@arndb.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=
=BB=D0=B0):
>>On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote:
>>> Add ability to use device tree bindings keeping existing setup.
>>
>>I see that there are no more in-tree users of the old
>>apds990x_platform_data, so I think it would be best to completely
>>remove that codepath and merge that structure into struct
>>apds990x_chip, to simplify the probing and avoid the extra
>>allocation.
>
> Thank you very much for your review, but is it mandatory to drop pdata=20
> in this particular patch set? To be honest this driver needs serious=20
> upgrades and refactoring, and I have no dedication to invest my time=20
> into refactoring it, moreover, I am not a maintainer of this driver,=20
> nor a full time kernel maintainer of any kind. I am doing what I am=20
> doing only because one of my devices uses this als but it is not=20
> something crucial.

We have a lot of drivers that are lacking the cleanup I'm asking
for, so I don't think I'd mandate it at this point, but I don't
actually expect the patch to be any more complicated in the end,
so just try it out.

I think at the minimum, please remove the include/platform_data
header and move the contents into the driver itself, I'd be fine
with that. If you can easily do further cleanup by dropping
the separate allocation and folding the apds990x_fw_probe()
function back into apds990x_probe(), please do that, just stop
at the point where you feel it gets too complicated.

    Arnd
