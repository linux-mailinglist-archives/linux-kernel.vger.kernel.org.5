Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2E7CAEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjJPQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjJPQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:11:11 -0400
Received: from 2.mo583.mail-out.ovh.net (2.mo583.mail-out.ovh.net [178.33.109.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A5FB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:11:07 -0700 (PDT)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.146.5])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 25EFE269C7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:51:55 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z9f7w (unknown [10.110.171.76])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9D0191FE94;
        Mon, 16 Oct 2023 15:51:54 +0000 (UTC)
Received: from RCM-web7.webmail.mail.ovh.net ([151.80.29.19])
        by ghost-submission-6684bf9d7b-z9f7w with ESMTPSA
        id pvT0JBpcLWU2DwEAAnawRQ
        (envelope-from <jose.pekkarinen@foxhound.fi>); Mon, 16 Oct 2023 15:51:54 +0000
MIME-Version: 1.0
Date:   Mon, 16 Oct 2023 18:51:54 +0300
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        skhan@linuxfoundation.org
Cc:     amandhoot12@gmail.com, rrangel@chromium.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Input: synaptics: enable InterTouch for ThinkPad L14 G1
In-Reply-To: <20231008080129.17931-1-jose.pekkarinen@foxhound.fi>
References: <20231008080129.17931-1-jose.pekkarinen@foxhound.fi>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5d857ff972e9203ef65ae2396c7285c0@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.101.52
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6636898479886935718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddtuddrhedvpdduhedurdektddrvdelrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-08 11:01, José Pekkarinen wrote:
> Observed on dmesg of my laptop I see the following
> output:
> 
> [   19.898700] psmouse serio1: synaptics: queried max coordinates: x
> [..5678], y [..4694]
> [   19.936057] psmouse serio1: synaptics: queried min coordinates: x
> [1266..], y [1162..]
> [   19.936076] psmouse serio1: synaptics: Your touchpad (PNP: LEN0411
> PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
> are not used, you might want to try setting
> psmouse.synaptics_intertouch to 1 and report this to
> linux-input@vger.kernel.org.
> [   20.008901] psmouse serio1: synaptics: Touchpad model: 1, fw:
> 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
> id: 3471, fw id: 2909640
> [   20.008925] psmouse serio1: synaptics: serio: Synaptics
> pass-through port at isa0060/serio1/input0
> [   20.053344] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input7
> [   20.397608] mousedev: PS/2 mouse device common for all mice
> 
> This patch will add its pnp id to the smbus list to
> produce the setup of intertouch for the device. After
> applying, the ouput will look like:
> 
> [   19.168664] psmouse serio1: synaptics: queried max coordinates: x
> [..5678], y [..4694]
> [   19.206311] psmouse serio1: synaptics: queried min coordinates: x
> [1266..], y [1162..]
> [   19.206325] psmouse serio1: synaptics: Trying to set up SMBus access
> [   19.209545] psmouse serio1: synaptics: SMbus companion is not ready 
> yet
> [   19.283845] psmouse serio1: synaptics: Touchpad model: 1, fw:
> 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
> id: 3471, fw id: 2909640
> [   19.283863] psmouse serio1: synaptics: serio: Synaptics
> pass-through port at isa0060/serio1/input0
> [   19.328959] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input8
> [   19.706164] mousedev: PS/2 mouse device common for all mice
> 
> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c 
> b/drivers/input/mouse/synaptics.c
> index ada299ec5bba..376a041c80b2 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN009b", /* T580 */
>  	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
>  	"LEN040f", /* P1 Gen 3 */
> +	"LEN0411", /* L14 Gen 1 */
>  	"LEN200f", /* T450s */
>  	"LEN2044", /* L470  */
>  	"LEN2054", /* E480 */

     Any comments here?

     Thanks!

     José.
