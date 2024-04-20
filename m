Return-Path: <linux-kernel+bounces-152332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8B8ABC88
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C66B21090
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1038DD2;
	Sat, 20 Apr 2024 17:07:55 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE47219E2;
	Sat, 20 Apr 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713632875; cv=none; b=o1W79Encsxrm9uOSsb1hAsV4NL1qC78MqZZvEuCmVrNc7+ERYNwFZW8cly9+fCUtLCd46PMnhraWGByCkQuK8XWbICj5/XC2jB2xOlh8acusSAwsp0LGXYxwKnkTcbKONZvtwkq5fiUucsLfI7FP+fAQ85yuCyOW7KR7eoDJgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713632875; c=relaxed/simple;
	bh=VRHiUA97gVKh2xnjyQ3bmP94uBKbQMCXUFaDLvl8IRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGcxtQApTpxLxASqLN3DDJMf1Ts1ACbGEvBNvZw1noWc40uFoEGec5BA84Sx4Uft5TCVym0RotqRxA+p4IpuAJHAtDZG5ZtfApxWLQ6jCCGeUSV3PzVxyjg82yHWAH9L4EecfFXgUFnXWh86ldJHCIHBgyq4cZiMLFoA92hrJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id F18171C0533;
	Sat, 20 Apr 2024 17:07:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 24ACB2F;
	Sat, 20 Apr 2024 17:07:48 +0000 (UTC)
Message-ID: <a51f703d4f8dc3b0917002c520ea6608ac642b75.camel@perches.com>
Subject: Re: [PATCH v2] remove indentation for common path [linux-next]
From: Joe Perches <joe@perches.com>
To: sundar <prosunofficial@gmail.com>, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de, 
	christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Date: Sat, 20 Apr 2024 10:07:47 -0700
In-Reply-To: <20240420164927.15290-1-prosunofficial@gmail.com>
References: <20240420164927.15290-1-prosunofficial@gmail.com>
Content-Type: text/markdown; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 24ACB2F
X-Stat-Signature: qmakgitgei14sankbxgqug8etbjhsjgy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Vb69p4R+rwa3/I17YCltIOGlNW2xZAqA=
X-HE-Tag: 1713632868-839488
X-HE-Meta: U2FsdGVkX19NYi9CfavpNt+nn8erIK/wv6gOjWAV73QVevcjJUwFW9DFv4qmo9yYnqXklQVdtK1TJjBKQ9hqaosLrJlXfZb4ue3jc077erl28xEKiqGqJkGnGqkt33yaBP03DBiBlkxZascifD+RuWauNdfVazgom61N43LaD6oHkgc/7x7Yr0n66Ya0yk2fca0zBYn3L7W92HYkEWX/vSXRMVyd/Emzr3bYnb/+dKqVV2IL/bQbGjH2ffvkw3MlMYwNIqiq/dVHRL40mJlpBW7gbfeM/xZlInAIYsrKduI9OdN8XIdeoQsB8Qj/sKN+

On Sat, 2024-04-20 at 22:19 +0530, sundar wrote:

> ```
Added check if pointer is null and removed indentation for common path
```

[]

> ```
diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7=
vpq904m.c
```

[]

> ```
@@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct=
 nb7vpq904m *nb7)
=20
 	ep =3D of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
=20
-	if (ep) {
-		ret =3D of_property_count_u32_elems(ep, "data-lanes");
-		if (ret =3D=3D -EINVAL)
-			/* Property isn't here, consider default mapping */
-			goto out_done;
-		if (ret < 0)
-			goto out_error;
-
-		if (ret !=3D DATA_LANES_COUNT) {
-			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret =3D -EINVAL;
-			goto out_error;
-		}
+	if (!ep)
+		return 0;
```


Not equivalent code as the out_error:

	of_node_put(ep);

isn't done



