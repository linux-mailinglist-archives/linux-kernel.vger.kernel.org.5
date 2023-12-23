Return-Path: <linux-kernel+bounces-10339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318981D310
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1CC1F22F30
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF248C1A;
	Sat, 23 Dec 2023 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfknLLTt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2418BE5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703318742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUBshkXYLnMOjBb5DKpZF415KAW7AprSbIw5W2JKUNk=;
	b=LfknLLTtRRmNNRsGwo5wW8aIKy/QHx8+MK2NCl3W8bYo+26H6wSn3bjt6Q1SKGsOvsq16I
	P1K/gYT9X046AziGJMOu9Ml6Psp+zqE4ibieibsAqs0/uPQrFQCpN7nNG06B7TTxzBQy21
	qCcfOXU+2O7rQbcf4F9ycoIpSQytuHs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-8JVjw865Oc2cLfj5iJ6_CA-1; Sat, 23 Dec 2023 03:05:39 -0500
X-MC-Unique: 8JVjw865Oc2cLfj5iJ6_CA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54cb8899c20so961351a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 00:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703318738; x=1703923538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUBshkXYLnMOjBb5DKpZF415KAW7AprSbIw5W2JKUNk=;
        b=GkFrC+Cjc7eOLefx27RDeKFhA5Egi5k2zPWDiO0ZKMZ592hggsSFaN1Gte4o503Euk
         pUjfQSlug64S7f5Hwv0LYBInegaZGl9zfiB+xmRtTXnkwIF3dPYZWag5kWDHgCBDJ+eA
         GYOUXBGu8PBV1TD3BMdjiQZbgt0JbU/rE2lHRrSoQLlk87ya5NGct68cTMd5+Z9ReG9N
         P/Yb/T8cxPcl0AMVXEqq5C/VtAAdPkox62S9ZDPLZ2xpcWBmRfzqCR9bX2IuDnKQ8a2Q
         e2WgaAYEW/YaC2QEoIGudVzivRJLa65I/KHJBU/3gzmLclGy89G8y01AY1navQ8fM37L
         jtSg==
X-Gm-Message-State: AOJu0Yx+Sv2SDOdL51tF6s0IpJV/AAP18DMSBDOUgeI6SqZ7BWHSPzir
	lyXXb20y9wPi2uBHAou+Z7UmAEzrNXSCN/M/fGl8Ih+0HPGBU8FnQUxPZdKUh86+YPFpqtQhyZN
	Gpsk40CkVmbXbW7xLr4vVrsdgh0ZHVUT6A016MSEKTqfKge+v
X-Received: by 2002:a50:c34d:0:b0:553:a1e0:311f with SMTP id q13-20020a50c34d000000b00553a1e0311fmr1606629edb.25.1703318738387;
        Sat, 23 Dec 2023 00:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHJdTN/u/DmP7Uvbt5/cBKSo9kCI2NkUXyLgyM//v5EmWOM390R9Q+ypDdpDISQLMLvG/fGzDYCHyI3Jl0b+8=
X-Received: by 2002:a50:c34d:0:b0:553:a1e0:311f with SMTP id
 q13-20020a50c34d000000b00553a1e0311fmr1606615edb.25.1703318738035; Sat, 23
 Dec 2023 00:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com> <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
In-Reply-To: <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 23 Dec 2023 13:35:26 +0530
Message-ID: <CAK3XEhOn+k7U88sMF2tXGSyhYvAL9u17sw6qvomL=oYESRMQkw@mail.gmail.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection profile
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 12:43=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> On Fri, Oct 13, 2023 at 3:06=E2=80=AFPM Ani Sinha <anisinha@redhat.com> w=
rote:
> >
> >
> >
> > > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <shradhagupta@linux.microso=
ft.com> wrote:
> > >
> > > Ifcfg config file support in NetworkManger is deprecated. This patch
> > > provides support for the new keyfile config format for connection
> > > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > > to generate the new network configuration in keyfile
> > > format(.ini-style format) along with a ifcfg format configuration.
> > > The ifcfg format configuration is also retained to support easy
> > > backward compatibility for distro vendors. These configurations are
> > > stored in temp files which are further translated using the
> > > hv_set_ifconfig.sh script. This script is implemented by individual
> > > distros based on the network management commands supported.
> > > For example, RHEL's implementation could be found here:
> > > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s=
/hv_set_ifconfig.sh
> > > Debian's implementation could be found here:
> > > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_s=
et_ifconfig
> > >
> > > The next part of this support is to let the Distro vendors consume
> > > these modified implementations to the new configuration format.
> > >
> > > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
> >
> > Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 a=
ddresses in ipv6 section:
>
> There is also another issue which is kind of a design problem that
> existed from the get go but now is exposed since keyfile support was
> added.
> Imagine we configure both ipv6 and ipv4 and some interfaces have ipv4
> addresses and some have ipv6.
> getifaddres() call in kvp_get_ip_info() will return a linked list per
> interface. The code sets ip_buffer->addr_family based on the address
> family of the address set for the interface. We use this to determine
> which section in the keyfile to use, ipv6 or ipv4. However, once we
> make this decision, we are locked in. The issue here is that
> kvp_process_ip_address() that extracts the IP addresses concatenate
> the addresses in a single buffer separating the IPs with ";". Thus
> across interfaces, the buffer can contain both ipv4 and ipv6 addresses
> separated by ";" if both v4 and v6 are configured. This is problematic
> as the addr_family can be either ipv4 or ipv6 but not both.
> Essentially, we can have a situation that for a single addr_family in
> hv_kvp_ipaddr_value struct, the ip_addr member can be a buffer
> containing both ipv6 and ipv4 addresses. Notice that
> process_ip_string() handles this by iterating through the string and
> for each ip extracted, it individually determines if the IP is a v6 or
> a v4 and adds "IPV6ADDR" or "IPADDR" to the ifcfg file accordingly.
> process_ip_string_nm() does not do that and solely makes the
> determination based on is_ipv6 values which is based on a single
> addr_family value above. Thus, it cannot possibly know whether the
> specific IP address extracted from the string is a v4 or v6. Unlike
> for ifcfg files, fir nm keyfiles, we need to add v4 and v6 addresses
> in specific sections and we cannot mix the two. So we need to make two
> passes. One for v4 and one for v6 and then add IPs in the respective
> sections.
>
> This issue needs to be looked into and unless it's resolved, we cannot
> support both ipv4 and ipv6 addresses at the same time.

In the short term, we should probably do this to avoid the mismatch :

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 318e2dad27e0..b77c8edfe663 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1216,6 +1216,9 @@ static int process_ip_string_nm(FILE *f, char
*ip_string, char *subnet,
                                                       subnet_addr,
                                                       (MAX_IP_ADDR_SIZE *
                                                        2))) {
+               if (is_ipv6 =3D=3D is_ipv4((char*) addr))
+                   continue;
+
                if (!is_ipv6)
                        plen =3D kvp_subnet_to_plen((char *)subnet_addr);
                else

But this is really a short term hack.


