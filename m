Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250BA766EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjG1NzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjG1NzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:55:12 -0400
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 06:55:10 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76EC2D57;
        Fri, 28 Jul 2023 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690552190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beUQirsMvfL7pIAGw8UPH+X8qz8ibMFPM/0HewqlhHM=;
        b=QpAGFR/o+41x3t9rha6iw1qPxQh+42P177EVztTm3SxBjqpEka2CYRuNxbBGG5z6Q6tOyP
        Nh8gQDIFZRkEHa/E/3AQpmr7DF/RENtO3twpdKzGvSvH6w/ZIszfwfWOHzvs9Hk2rFOeod
        NXdjLqijb/3NaUZGju19tap9yVk2eQk=
From:   Sven Eckelmann <sven@narfation.org>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH net] batman-adv: Do not get eth header before
 batadv_check_management_packet
Date:   Fri, 28 Jul 2023 15:49:46 +0200
Message-ID: <10396914.nUPlyArG6x@sven-l14>
In-Reply-To: <20230728133850.5974-1-repk@triplefau.lt>
References: <20230728133850.5974-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2318948.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2318948.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 28 Jul 2023 15:49:46 +0200
Message-ID: <10396914.nUPlyArG6x@sven-l14>
In-Reply-To: <20230728133850.5974-1-repk@triplefau.lt>
References: <20230728133850.5974-1-repk@triplefau.lt>
MIME-Version: 1.0

On Fri, 28 Jul 2023 15:38:50 +0200, Remi Pommarel wrote:
> If received skb in batadv_v_elp_packet_recv or batadv_v_ogm_packet_recv
> is either cloned or non linearized then its data buffer will be
> reallocated by batadv_check_management_packet when skb_cow or
> skb_linearize get called. Thus geting ethernet header address inside
> skb data buffer before batadv_check_management_packet had any chance to
> reallocate it could lead to the following kernel panic:
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Do not get eth header before batadv_check_management_packet
      commit: eac27a41ab641de074655d2932fc7f8cdb446881

Kind regards,
	Sven

--nextPart2318948.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTDx3sACgkQXYcKB8Em
e0Y7nA//f+y3W/Key/lGHTIdz7e2o1AK1cskjKQSEK0MRZTG83aYw6UET5x70CSB
enh7GVx8/oVW5PJTRzgSevACLiY5TBmdVUsnvB15Jd/GjpgGR6+5d2qzlg3ljo7Y
qX9JkYEqCmbyaca0MrBooQJD0osnfI4Yp+06kaIlYPfhtM0D/Z+9vq2N6vt/6P78
iMR/aaRkMef9wsvCBF+Hqoo2fazSxb/4OBFsVS5HWvHHo0E30difswthoh794uO+
mnisBoitYzQAQ+EGbHM7rOGiymUl6KelZjOe7HCSlrhC0C6C6P5LWYUcegmW1B7w
Dnrni2OXXn2EurdjVVPLQWs9xOvUYbmf125e8aOwW/RAY7ZiTP4F+i1bYMe65TTW
UFCMUl86894QOo0aL7uZ+/aBV03M7kGUNQnLNWlpA9zlK5zr3dNtgpbJiOF1Z+NP
O/8+o5Ld7FjqaxAqK76xA8D5yY2BQMCW21n7M2CecoF4EeqngZ1gPOkq2KpIPFTC
AkEnhkUPa1nsvKUZRoBegYyHEzXqJQITmv5FtdihJLuFqHGS6WI7xEZ+zWJSJbIK
HEHyA6lfzzqK/hEPo5UcU8rKhdazz0rD8YqteDlVhB3g6jvAtFdLadOMU0qxL8qC
FoHL3B9xo8LU7SHEPufi8pLqfZLYeg49ix9Zx9ObzPfGl9v4Taw=
=Xu6Q
-----END PGP SIGNATURE-----

--nextPart2318948.iZASKD2KPV--



