Return-Path: <linux-kernel+bounces-97922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C960A8771A8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354E8B20DC0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1440879;
	Sat,  9 Mar 2024 14:36:00 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE592030B;
	Sat,  9 Mar 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994959; cv=none; b=hncmxFbcf+rgcbtA31cD3w88nzlp1UPURJyO0HkR7kVZQUbilFfFrqlsFi3zq6nYZ7aGV+FeZkuU9gw2D3K8R1nANX9U+iZoamSGMfxLqoW3a4usWs/pJDeBgfF2XhKzCOLWYlAl+6qCPkxm6sQMEWLZsWh8V6y+EZ8kpLJknYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994959; c=relaxed/simple;
	bh=xA/9kOSEVmLw9nLE0NKCnQ73WhTf8Q1gxFqklnWgViU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTZNDWRqpW/bIVlvSF2zHiUcQKMA+hVRGmjaaBGioBK1d+6ewGWucyaF5z7D+qGKxXk+trQdwwvH7kXFg+Jg8bKDMQwr9RYgY2lBaWTgce/tsj5aP3gCPKV+qSfhJF05xWtVEMnSS7a+nITqda+fB6r0nYVnk9eqJPPF/wxfehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 86F5580A43;
	Sat,  9 Mar 2024 14:26:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id ADAC02D;
	Sat,  9 Mar 2024 14:26:30 +0000 (UTC)
Message-ID: <4f38500b4d798ad8effd59fef41353439f76fec3.camel@perches.com>
Subject: Re: [PATCH net-next v2 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
From: Joe Perches <joe@perches.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
  Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,  Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Sat, 09 Mar 2024 06:26:28 -0800
In-Reply-To: <20240308104725.2550469-1-o.rempel@pengutronix.de>
References: <20240308104725.2550469-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: ADAC02D
X-Rspamd-Server: rspamout08
X-Stat-Signature: i147iw4rs346ixqkpt96tgzf3s85nt13
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+3BSoxTVywlEzBGCLj6QmH45p+lmVlJCQ=
X-HE-Tag: 1709994390-270477
X-HE-Meta: U2FsdGVkX18F/9aSsyZ3Uo+44q24i3iFYpycJOxTQNUDfdp4WDk/ZfGICVQUfEnZUAVK1CE3Ywme4lH/HPz7QSpjvpgNfPZLEaWWvEIVoFK0M1b1RNW30l57XAFXX9ggSm8RaMNxBcXpcS1LoCDeInysL1qTuoM7GmpxTfb4aQX9e4x4EQAHuiiHIgVbFasSg2OamvPXKCskntE8EP6xx0go/BFvSP4RU5fTU/tV+7UvNq9hbXpT25+eDG9V4Hz5upIo8VpvD0woCUALkamgZocImvHBVYocRqAqKyGQui5LmqVGUe8SreNp0Q1KI6L8

On Fri, 2024-03-08 at 11:47 +0100, Oleksij Rempel wrote:
> Enhance the error reporting mechanism in the switchdev framework to
> provide more informative and user-friendly error messages.
>=20
> Following feedback from users struggling to understand the implications
> of error messages like "failed (err=3D-28) to add object (id=3D2)", this
> update aims to clarify what operation failed and how this might impact
> the system or network.
>=20
> With this change, error messages now include a description of the failed
> operation, the specific object involved, and a brief explanation of the
> potential impact on the system. This approach helps administrators and
> developers better understand the context and severity of errors,
> facilitating quicker and more effective troubleshooting.
>=20
> Example of the improved logging:
>=20
> [   70.516446] ksz-switch spi0.0 uplink: Failed to add Port Multicast
>                Database entry (object id=3D2) with error: -ENOSPC (-28).
> [   70.516446] Failure in updating the port's Multicast Database could
>                lead to multicast forwarding issues.
> [   70.516446] Current HW/SW setup lacks sufficient resources.

In general, I think the "problem" is being written with 80
columns in mind in the source and is not well thought out
how someone might read the log.

Generally, I think it's better to have single line statements
in the log.

[]

> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
[]
> @@ -244,6 +244,106 @@ static int switchdev_port_obj_notify(enum switchdev=
_notifier_type nt,
>  	return 0;
>  }

>=20
> +static void switchdev_obj_id_to_helpful_msg(struct net_device *dev,
> +					    enum switchdev_obj_id obj_id,
> +					    int err, bool add)
> +{
> +	const char *action =3D add ? "add" : "del";
> +	const char *reason =3D "";
> +	const char *problem;
> +	const char *obj_str;
> +
> +	switch (obj_id) {
> +	case SWITCHDEV_OBJ_ID_UNDEFINED:
> +		obj_str =3D "Undefined object";
> +		problem =3D "Attempted operation is undefined, indicating a "
> +			  "possible programming error.\n";

My preference would be to write
		problem =3D "Attempted operation is undefined indicating a possible progr=
amming error\n";

> +		break;
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		obj_str =3D "VLAN entry";
> +		problem =3D "Failure in VLAN settings on this port might disrupt "
> +		          "network segmentation or traffic isolation, affecting\n"
> +		          "network partitioning.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> +		obj_str =3D "Port Multicast Database entry";
> +		problem =3D "Failure in updating the port's Multicast Database "
> +			  "could lead to multicast forwarding issues.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		obj_str =3D "Host Multicast Database entry";
> +		problem =3D "Failure in updating the host's Multicast Database"
> +		          "may impact multicast group memberships or\n"

No space after Database makes the output "Databasemay"

> +			  "traffic delivery, affecting multicast communication.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_MRP:
> +		obj_str =3D "Media Redundancy Protocol configuration for port";
> +		problem =3D "Failure to set MRP ring ID on this port prevents"
> +			  "communication with the specified redundancy ring,\n"

portcommunication

> +			  "resulting in an inability to engage in MRP-based "
> +			  "network operations.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_TEST_MRP:
> +		obj_str =3D "MRP Test Frame Operations for port";
> +		problem =3D "Failure to generate/monitor MRP test frames may lead"
> +			  "to inability to assess the ring's operational\n"

leadto

> +			  "integrity and fault response, hindering proactive "
> +			  "network management.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +		obj_str =3D "MRP Ring Role Configuration";
> +		problem =3D "Improper MRP ring role configuration may create "
> +		          "conflicts in the ring, disrupting communication\n"
> +			  "for all participants, or isolate the local system "
> +			  "from the ring, hindering its ability to communicate "
> +			  "with other participants.\n";

A bunch of unnecessary commas.

> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_STATE_MRP:
> +		obj_str =3D "MRP Ring State Configuration";
> +		problem =3D "Failure to correctly set the MRP ring state can "
> +		          "result in network loops or leave segments without\n"
> +			  "communication. In a Closed state, it maintains loop "
> +			  "prevention by blocking one MRM port, while an Open\n"
> +			  "state activates in response to failures, changing "
> +			  "port states to preserve network connectivity.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_IN_TEST_MRP:
> +		obj_str =3D "MRP_InTest Frame Generation Configuration";
> +		problem =3D "Failure in managing MRP_InTest frame generation can "
> +			  "misjudge the interconnection ring's state, leading\n"
> +			  "to incorrect blocking or unblocking of the I/C port."
> +			  "This misconfiguration might result in unintended\n"
> +			  "network loops or isolate critical network segments, "
> +			  "compromising network integrity and reliability.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_IN_ROLE_MRP:
> +		obj_str =3D "Interconnection Ring Role Configuration";
> +		problem =3D "Failure in incorrect assignment of interconnection "
> +			  "ring roles (MIM/MIC) can impair the formation of the\n"
> +			  "interconnection rings.\n";
> +		break;
> +	case SWITCHDEV_OBJ_ID_IN_STATE_MRP:
> +		obj_str =3D "Interconnection Ring State Configuration";
> +		problem =3D "Failure in updating the interconnection ring state "
> +			  "can lead in case of Open state to incorrect blocking\n"
> +			  "or unblocking of the I/C port, resulting in unintended"
> +			  "network loops or isolation of critical network\n";
> +		break;
> +	default:
> +		obj_str =3D "Unknown object";
> +		problem	=3D "Indicating a possible programming error.\n";
> +	}
> +
> +	switch (err) {
> +	case -ENOSPC:
> +		reason =3D "Current HW/SW setup lacks sufficient resources.\n";

And adding a newline here puts an unnecessary newline between
logging output as the format also has a trailing newline.


> +		break;
> +	}
> +
> +	netdev_err(dev, "Failed to %s %s (object id=3D%d) with error: %pe (%d).=
\n%s%s\n",
> +		   action, obj_str, obj_id, ERR_PTR(err), err, problem, reason);
> +}
> +


