Return-Path: <linux-kernel+bounces-10331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95B81D2D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8C91C22219
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66F9460;
	Sat, 23 Dec 2023 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er/ksrzK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AF944C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703315623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=squQ29LS3om98KbFUvaUmQ9St+SmyXFv/Z9gYa40yWE=;
	b=Er/ksrzKzu8YpxGXJ5Ykqf7M6wVRKjGFPoc/B2y1xx4bU0/JqUKQY8BLs70xy7IROMfKUx
	wl34Cqj3BKuFze4XuhkTujzTHA0lUsJUuZPsGfDDU8iCyK8YGhB1jTh3MWzyjDlqmnFw7/
	5F8Uj2eEhNEuRkdkN5osQmGL43tzp0U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-NoRbDWZ5MO6ZCpYjbf3_-g-1; Sat, 23 Dec 2023 02:13:41 -0500
X-MC-Unique: NoRbDWZ5MO6ZCpYjbf3_-g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1f99db3dd0so122281766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703315620; x=1703920420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=squQ29LS3om98KbFUvaUmQ9St+SmyXFv/Z9gYa40yWE=;
        b=Lg9QocBov8pVcVjRRUj5VWiEcOfzdr++iBIAAxY6gOhIbN2MgGLt4S0QTeCfDMtYuG
         6yNqv+eP+ZB6+MsFF1+HDfJel7nQTqUIP7FXUkzzlvyJK/+Q9ODX8rlph+9lM0j4mF/I
         JyX1E+QWJAHsFPmoBI0P2mseAZHxU6/sRf95KU50kPUIXUGZciigvP/Po8wa1z5wuBKp
         WqlW8IAHCo/jyWfksfXOB83Zx9bV571UAwgFi5GReDbWW7i/da0E+mMEbRPKT/NMF4su
         +dVUCpWOyqDVqAeQa3ht5ZTO8KELjOpgepMQAWMdWoEspLSx6EOZIqZGmQCfJ/0jad/H
         8ibw==
X-Gm-Message-State: AOJu0YwyZaMQVLzdC1lLZzLR29f0xAeXG5QHWNnhTwmy6A42vL7D3Pz5
	ZS0hyLH+BqLtorF8xmhyhWeMayENGJn8yd5b91ckAR9+GMokxeTOsA1fl/xBXb22REKaIPfskH5
	YcgtDrGx1KYmFuimXVbidI3pFq/PBkcH3w6Ni3tPoj0E+ezaW
X-Received: by 2002:a17:906:1407:b0:a24:20f:d63a with SMTP id p7-20020a170906140700b00a24020fd63amr1383531ejc.97.1703315620197;
        Fri, 22 Dec 2023 23:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYEMBBT5Zw58uO7AdGyGk7/pEuqfRVBPHrUuH9cZkOOYZHJE9QLK4Rz/ermUvC5DihlRZy0a1AG5+DeW8vH0k=
X-Received: by 2002:a17:906:1407:b0:a24:20f:d63a with SMTP id
 p7-20020a170906140700b00a24020fd63amr1383516ejc.97.1703315619891; Fri, 22 Dec
 2023 23:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1696847920-31125-1-git-send-email-shradhagupta@linux.microsoft.com>
 <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
In-Reply-To: <A8905E07-2D01-46D6-A40D-C9F7461393EB@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 23 Dec 2023 12:43:28 +0530
Message-ID: <CAK3XEhMzLvxTbP+sFjD7btfdjw5uxyAccdT09d4hcw5hkCKXHQ@mail.gmail.com>
Subject: Re: [PATCH v8] hv/hv_kvp_daemon:Support for keyfile based connection profile
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Michael Kelley <mikelley@microsoft.com>, Olaf Hering <olaf@aepfle.de>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 3:06=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
>
>
> > On 09-Oct-2023, at 4:08 PM, Shradha Gupta <shradhagupta@linux.microsoft=
.com> wrote:
> >
> > Ifcfg config file support in NetworkManger is deprecated. This patch
> > provides support for the new keyfile config format for connection
> > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > to generate the new network configuration in keyfile
> > format(.ini-style format) along with a ifcfg format configuration.
> > The ifcfg format configuration is also retained to support easy
> > backward compatibility for distro vendors. These configurations are
> > stored in temp files which are further translated using the
> > hv_set_ifconfig.sh script. This script is implemented by individual
> > distros based on the network management commands supported.
> > For example, RHEL's implementation could be found here:
> > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/h=
v_set_ifconfig.sh
> > Debian's implementation could be found here:
> > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set=
_ifconfig
> >
> > The next part of this support is to let the Distro vendors consume
> > these modified implementations to the new configuration format.
> >
> > Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
>
> Was this patch tested with ipv6? We are seeing a mix of ipv6 and ipv4 add=
resses in ipv6 section:

There is also another issue which is kind of a design problem that
existed from the get go but now is exposed since keyfile support was
added.
Imagine we configure both ipv6 and ipv4 and some interfaces have ipv4
addresses and some have ipv6.
getifaddres() call in kvp_get_ip_info() will return a linked list per
interface. The code sets ip_buffer->addr_family based on the address
family of the address set for the interface. We use this to determine
which section in the keyfile to use, ipv6 or ipv4. However, once we
make this decision, we are locked in. The issue here is that
kvp_process_ip_address() that extracts the IP addresses concatenate
the addresses in a single buffer separating the IPs with ";". Thus
across interfaces, the buffer can contain both ipv4 and ipv6 addresses
separated by ";" if both v4 and v6 are configured. This is problematic
as the addr_family can be either ipv4 or ipv6 but not both.
Essentially, we can have a situation that for a single addr_family in
hv_kvp_ipaddr_value struct, the ip_addr member can be a buffer
containing both ipv6 and ipv4 addresses. Notice that
process_ip_string() handles this by iterating through the string and
for each ip extracted, it individually determines if the IP is a v6 or
a v4 and adds "IPV6ADDR" or "IPADDR" to the ifcfg file accordingly.
process_ip_string_nm() does not do that and solely makes the
determination based on is_ipv6 values which is based on a single
addr_family value above. Thus, it cannot possibly know whether the
specific IP address extracted from the string is a v4 or v6. Unlike
for ifcfg files, fir nm keyfiles, we need to add v4 and v6 addresses
in specific sections and we cannot mix the two. So we need to make two
passes. One for v4 and one for v6 and then add IPs in the respective
sections.

This issue needs to be looked into and unless it's resolved, we cannot
support both ipv4 and ipv6 addresses at the same time.

Thoughts?


