Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A363B7FC472
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjK1Tuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjK1Tup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:50:45 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668AA10F0;
        Tue, 28 Nov 2023 11:50:51 -0800 (PST)
Received: from [127.0.0.1] (ip-109-43-115-169.web.vodafone.de [109.43.115.169])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 599866E;
        Tue, 28 Nov 2023 20:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701201049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qx987Q56BapeU8URf5u34Lr6fDvrB7kSuGpcq8K1euU=;
        b=Qp0qDmXd2IqE5XgI3pEBnzHX+/g3nh2g2B0lcDHawAXQegtpC4VaW+7oamRtInuiIS8Rvu
        ZvAfRngg6Nz3U26uxMyW5yzuWX46LLtDWTOe6fqsy9tdZjaZ+g8xpoWZRD/fZnRqgCIfZV
        oY3hfXpkTF+zgjOg/pbgsdCJg6KUHOPmvi9bAF0kq21OkWkkLFr0BARBXs5TiSQHmSN28I
        f7Kng8/jSs/4d4wmQpHa1LSy0RT1xruILL3Zvzl0q9kZUY2WfJumMh9r3dEzcJ0phMcdTS
        RFsCubLpaucYl+8YFAoHxnwD5NNtWwSbi4i772nyyDcpJhdcOoWrffo+VxOtvA==
Date:   Tue, 28 Nov 2023 20:50:50 +0100
From:   Michael Walle <michael@walle.cc>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michael Walle <mwalle@kernel.org>
CC:     Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        dave.stevenson@raspberrypi.com, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        marijn.suijten@somainline.org, mripard@kernel.org,
        neil.armstrong@linaro.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, rfoss@kernel.org, sean@poorly.run,
        tzimmermann@suse.de, tony@atomide.com,
        alexander.stein@ew.tq-group.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_03/10=5D_drm/mipi-dsi=3A_add_API_fo?= =?US-ASCII?Q?r_manual_control_over_the_DSI_link_power_state?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAA8EJpr9PDgSrTpP2-joQ09fxmJKZB1B+ESbDbMjkLNiqZ1m3A@mail.gmail.com>
References: <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com> <20231127160658.2164612-1-mwalle@kernel.org> <CAA8EJpphwXoKnzDkY3cBqzsDZwdw+nze-Ev2toPBJm-2VJvY_g@mail.gmail.com> <dce76a6e1321a6374ad39125bead56b3@kernel.org> <CAA8EJpr9PDgSrTpP2-joQ09fxmJKZB1B+ESbDbMjkLNiqZ1m3A@mail.gmail.com>
Message-ID: <14D9F495-425D-47FA-AD0D-F7299285936F@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> > DSI device lifetime has three different stages:
>> >> > 1=2E before the DSI link being powered up and clocking,
>> >> > 2=2E when the DSI link is in LP state (for the purpose of this que=
stion,
>> >> > this is the time between the DSI link being powered up and the vid=
eo
>> >> > stream start)
>> >> > 3=2E when the DSI link is in HS state (while streaming the video)=
=2E
>> >>
>> >> It's not clear to me what (2) is=2E What is the state of the clock a=
nd
>> >> data lanes?
>> >
>> > Clk an Data0 should be in the LP mode, ready for LP Data Transfer=2E
>>
>> Then this is somehow missing
>> https://docs=2Ekernel=2Eorg/gpu/drm-kms-helpers=2Ehtml#mipi-dsi-bridge-=
operation
>>
>>    A DSI host should keep the PHY powered down until the pre_enable
>> operation
>>    is called=2E All lanes are in an undefined idle state up to this poi=
nt,
>> and
>>    it must not be assumed that it is LP-11=2E pre_enable should initial=
ise
>> the
>>    PHY, set the data lanes to LP-11, and the clock lane to either LP-11
>> or HS
>>    depending on the mode_flag MIPI_DSI_CLOCK_NON_CONTINUOUS=2E
>>
>> So I don't think these three states are sufficient, see below, that
>> there
>> should be at least four=2E
>
>Which one is #4?

enabled clock lane (HS mode), data lanes in LP-11

-michael

>>
>> >
>> > I don't think we support ULPS currently=2E
>> >
>> >
>> >>
>> >> I'm facing similar issues with the tc358775 bridge=2E This bridge ne=
eds
>> >> to release its reset while both clock and data lanes are in LP-11
>> >> mode=2E
>> >> But then it needs to be configured (via I2C) while the clock lane is
>> >> in enabled (HS mode), but the data lanes are still in LP-11 mode=2E
>> >>
>> >> To me it looks like there is a fouth case then:
>> >> 1=2E unpowered
>> >> 2=2E DSI clock and data are in LP-11
>> >> 3=2E DSI clock is in HS and data are in LP-11
>> >> 4=2E DSI clock is in HS and data is in HS
>> >>
>> >> (And of course the bridge needs continuous clock mode)=2E
>> >>
>> >> > Different DSI bridges have different requirements with respect to =
the
>> >> > code being executed at stages 1 and 2=2E For example several DSI-t=
o-eDP
>> >> > bridges (ps8640, tc358767 require for the link to be quiet during
>> >> > reset time=2E
>> >> > The DSI-controlled bridges and DSI panels need to send some comman=
ds
>> >> > in stage 2, before starting up video
>> >> >
>> >> > In the DRM subsystem stage 3 naturally maps to the
>> >> > drm_bridge_funcs::enable, stage 1 also naturally maps to the
>> >> > drm_bridge_funcs::pre_enable=2E Stage 2 doesn't have its own place=
 in
>> >> > the DRM call chain=2E
>> >> > Earlier we attempted to solve that using the pre_enable_prev_first=
,
>> >> > which remapped pre-enable callback execution order=2E However it h=
as led
>> >> > us to the two issues=2E First, at the DSI host driver we do not kn=
ow
>> >> > whether the panel / bridge were updated to use pre_enable_prev_fir=
st
>> >> > or not=2E Second, if the bridge has to perform steps during both s=
tages
>> >> > 1 and 2, it can not do that=2E
>> >> >
>> >> > I'm trying to find a way to express the difference between stages =
1
>> >> > and 2 in the generic code, so that we do not to worry about partic=
ular
>> >> > DSI host and DSI bridge / panel peculiarities when implementing th=
e
>> >> > DSI host and/or DSI panel driver=2E
>> >>
>> >> For now, I have a rather hacky "=2Edsi_lp11_notify" callback in
>> >> drm_bridge_funcs which is supposed to be called by the DSI host whil=
e
>> >> the
>> >> clock and data lanes are in LP-11 mode=2E But that is rather an RFC =
and
>> >> me
>> >> needing something to get the driver for this bridge working=2E Becau=
se
>> >> it's
>> >> badly broken=2E FWIW, you can find my work-in-progress patches at
>> >> https://github=2Ecom/mwalle/linux/tree/feature-tc358775-fixes
>> >>
>> >> -michael
>> >>
>> >
>> >
>> > --
>> > With best wishes
>> > Dmitry
>
>
>

