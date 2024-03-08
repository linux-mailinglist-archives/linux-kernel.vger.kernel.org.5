Return-Path: <linux-kernel+bounces-96786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6861F87616B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17141F229D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48853E00;
	Fri,  8 Mar 2024 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ptfkd3oq"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B035339B;
	Fri,  8 Mar 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891925; cv=fail; b=j8Shu7cn3hVN2oBxFvQLX+Mj9aKgISfF74ObjWAD97b3tGOG7TnMDTs9qCWrfomRW+QbiSpKLLCprAk2VD+Nh6J5moM1pjcytCQ/OYQSpib0/YRxq3fsujaa7kMv9578+JBv0ZFcaCbdOYYE+tyDIrzTkMb6yWrDFdlsoulKC2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891925; c=relaxed/simple;
	bh=DH8WOFcD7yEWnTFA/vrIAEEWw1xSpL5Kg4hnnSg8BDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzSJNM4eKb6czbUN0dH85umqN2iOGx6TVqLGLM/EDOQSSb4A5/uqWmQG7H0tR8QkLyehXGvhsNsDmdx9qIL+CozSv5VZIb1jTuJnjMD8XhuyX5W8lnDJJSPEJgXgBdfYKdPcDn6liTH/v8qYpeMpbx3OYj2lXzRX9P5T5YrIvW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ptfkd3oq; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4288PmBY022708;
	Fri, 8 Mar 2024 01:58:19 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj629fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 01:58:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHXPo6sPicSntSgKeX8OLoqQ71ibFKFvaFDh8Ln0nUsJ54rU5hLoqU7iTO9yhWMOY89Mp9OzpHXVW7twGaJO1eXJKHly7JQ/RVLzaicphq1ZOSFDgDWV5y7BdMJaR3H5cJ3AXMmPiFx1u8z1uoCE94Z/B2aTGk5Wp9ExaLPzP54psYtC1uX4uDnUH4b8tLEP18LTWHLqsr9vx4/tukTaDL+P1MOLbn5Gp3YwABc+BWIjfKZ9VGNd/enR2PAENX5WI4XUzML06j4WgSENfcdxnwHMVHSd8COCY7gTexBbBhIk+awBhXfZg7prNJqIaoUceyro/F5Xry04BOMX4aa11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NatEYhhhPuQlPiDusggswpLrRF3kd/Aq4HHyhWx7TA=;
 b=YYfOqUB/ouDxNpzPmJKrmwrVCRJC9FyOEvY+bHAiabcpp/frnRs5V/ICaYjWHSoRilS0eDSgDXxKumg+tcJzAN3vQVDvtglu5XyuLTiBxhlF0sK5m1ebUTObnAsGSCu4sN5uPKejrK8nSOogKDBM4WyoCkrnb4WO5Q0VhnFLGiRGC1NnmUbpLAP+K0/K7d9ybpyu/r6W5CDft+ltiDv09iDovtIH9scGmJEQTkyV8XSFjIKSLF2hvP+haMwXZYTF1ByWC77BUjQCNUwIo9NXEcLpQi7tUgboLfNBHTZiUsutZWH9KgowuWWM73aO2fLygX5vJxTaZSsX+IDd28kbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NatEYhhhPuQlPiDusggswpLrRF3kd/Aq4HHyhWx7TA=;
 b=Ptfkd3oqyxmQlODwVxneIHFZn3WmcOb6joACG/EbBGCOdUyupYnbYh8PcfaRrSAcSEdJe+LvqLg75y5i07lcJO6APGbZr2xzjbSMekiJN8DMcBTykG6WlDTQlKu+XXJ9vfmGZRmgq52t9jqThwFsIDU/VX91brcxpKCPJeLSexo=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by CO1PR18MB4794.namprd18.prod.outlook.com (2603:10b6:303:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 09:58:13 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::d8da:f765:b92b:b3a7%3]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 09:58:12 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Karthik Sundaravel <ksundara@redhat.com>,
        "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>,
        "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "jiri@resnulli.us"
	<jiri@resnulli.us>,
        "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>,
        "rjarry@redhat.com"
	<rjarry@redhat.com>,
        "aharivel@redhat.com" <aharivel@redhat.com>,
        "vchundur@redhat.com" <vchundur@redhat.com>,
        "cfontain@redhat.com"
	<cfontain@redhat.com>
Subject: RE: [EXTERNAL] [PATCH v5] ice: Add get/set hw address for VFs using
 devlink commands
Thread-Topic: [EXTERNAL] [PATCH v5] ice: Add get/set hw address for VFs using
 devlink commands
Thread-Index: AQHabxHQquQfD7PIsE2pPo7WiunferEtna9w
Date: Fri, 8 Mar 2024 09:58:11 +0000
Message-ID: 
 <SJ0PR18MB5216589DBE2D5345BD016BE0DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240305152641.53489-1-ksundara@redhat.com>
In-Reply-To: <20240305152641.53489-1-ksundara@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|CO1PR18MB4794:EE_
x-ms-office365-filtering-correlation-id: b81d2747-2442-4872-9c1a-08dc3f5643f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ezSsnEXgOKs4JaT/CxxlhFdS3ULw/THed+GqQ6ffMxHtcsBsc5UGOETBuNUVJFUuia6vJF6iZZqc20YyQAcpEDJNMozZdem8wDGgr+OB5rl/HIWJrxDnhO7zpmdi0UkQTN3ye7mvuhMZqUwlXBeEgt4cg0lkfA8HDEH11d8hWuxkNWRg8BSaWpL4awyT7IYMRJgzY5Ko99ban/ccrM2eIZaIzGhgVT0yqI5o20tyDYq3p1bUKzVhKEYdPk1SBD7rNKS4dGrI2FroAkFF3TWbnyn13MbE34uRwP4t2HcxY5yzeLBzYzcBO0+d1dF/RbzntVU2q8ZCmLVsmiguOLXTdZ7LYo4TMXSUGD2QeSXk484DIEdCeF5/+8jgAwO7gTJm1BFXTnFHU5TDb89Jh6pEwW0w7MKC6FiP+ckB73+QuDfDAuGARiF7WajaEK431EM/fT7kWgBLZPh1qNYFrOKE6VHpByqI/QtpUeNTgFhpDW7Uyh0xQ9wxQnc7m/0KVFy6bW3tVHJ7y7gvw+DpOJyNjwDeZnNhCBYwHLMwCbhrHijLDsNXX6V6BMpbPUxtD3o5jGF4l+idtoKcq1vdPUbMZ2IyU0l7NZkNxCnkJ8PHprkikD/Di2sbyMAzabSfFRuBc4K7/qdNGApEj33ahvp3/NctseXeuSi5eLbhYSTl5LwuN4+8/IinZNm/gXBqGS4JmVgTjj8v4E77O3ieJadKWgcwipX01flxnuRsvaANJ5I=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?E5Bn8fkHjuNMTcivpqC4mc4OP5tD+El9VUD9fK5nPppw/Z5AypdzteBpbOtK?=
 =?us-ascii?Q?EOkyOz0TEei5p8TgvTz/6gCqG+9BDeR9ZOIwIvNhnuLK0lNtcKjic0YAzESb?=
 =?us-ascii?Q?h5Jh5eX4xYQhgw0ML+MclZ1wcFFlapk0dykfJQRf0ePLBH0qb+XoPKBiatbm?=
 =?us-ascii?Q?FM5SJ0gEQIXopo4dz66RVgHQ3bG2cT8lZD6wzyoTcUBG8Ks292bOuf8TfG3D?=
 =?us-ascii?Q?oEg3q7DQbp6P4RV9OCI44eaGfWnpTMh06ObCD3ejuVVsCELElvi1qZyte/at?=
 =?us-ascii?Q?D+8k09mCHMi5e2T68T/BERi+NFFRuFppNs/u3QPZrG3y9Se2hiXfbi1uVRzX?=
 =?us-ascii?Q?09DnUs4L+z1weAgvlYQXFUfizrOb05AqXylwpG7d3WKbajX0bNMnIoKeV8cO?=
 =?us-ascii?Q?R8G8pNKuNDQQS9KcbaNdcB455DELU3LRp/iOwwyTIHmilXr+amosb8f45+9w?=
 =?us-ascii?Q?61YdTgC7LhK/pbM97BqlDthowgdi+yKq6x05lIMo5oGlSWlGftyyVU9BinUw?=
 =?us-ascii?Q?lNxQj4ppsmZj6Erhl6jccmpVZoFeyKlD8UO15yfaByMwrXQtqrPE9kjh1Y0e?=
 =?us-ascii?Q?fKiHogMxTaO9Feq2Eh/AdQSnLwJYU0KEG8BqyG6wWPb/uyJnSbE1Wdpjf/Og?=
 =?us-ascii?Q?B/A/RhEJ8iXp5Ya+OloCtDNsa7At29J06YEGHCvwiGYoOcppPURUU2lByzS6?=
 =?us-ascii?Q?fRi55UKaqOxhU7jop2e1E/ohnJykkrmYyFkITQ8zVELM9TVykmJiScY6njhm?=
 =?us-ascii?Q?T/bW92ScHyIwOZFecC5lILbHqqAJbUGVwz7toBvjCzuMZN7FRGW/HOlAPt9D?=
 =?us-ascii?Q?rnzUtwdNCnWvcaE7N9AttAuHx81qC4L6XYvRsMDASjtBYH5NfFfNh8KnKSzd?=
 =?us-ascii?Q?IYK5qFcY8KUvIu6m669oGZcj8ZlkCDivW49PSW/Dj/yh1fjMEVUzExpWEysk?=
 =?us-ascii?Q?TnlJcEioqFRxX539Egm1SW4+PYeKv2IYCyQuT65POjT/gFMVWB4YQvh3iDfG?=
 =?us-ascii?Q?MWqY9XKf1lrAtrJV7bytVl9fK40RZZcHH1U3hN4peMJMoEQxC0qVRTCR2ufr?=
 =?us-ascii?Q?RUbORpQVOYAg7qyHAno0oSL0vTLpSf0gcrmkQdJe6syJrLqtSe02jocQP2QM?=
 =?us-ascii?Q?tJ133pGAuQzVfOs6B8FROTTk6G0kQBZHfgNe90chFF8ohyJJyjCA4YC8918I?=
 =?us-ascii?Q?qP1MpGl5YrDpaOpmCV6wcBThW68dueGUaCF9iglz4/kY4X8Lkr9146kIqrFa?=
 =?us-ascii?Q?lxx8UsUaBxBwhURbqvFgun7uV2cziIQIUpaT/bGCeiifxAz5T1PcQzzBGc8D?=
 =?us-ascii?Q?5JMFxjrJVfnVCSDwB7DTeeYUm4m1FTEWLb/GPmdfaoYhiDxMoFpD2OptXoHS?=
 =?us-ascii?Q?6emOeN44a8saQ8qG4/buWz5IZs7xG3qRhVLx5EKbIua7EgkFLrS+ZpOrCOQc?=
 =?us-ascii?Q?qwZmjvpLGZzBjC7ViyG+yTF9YFptv2v9z32I8uhSsm8d6rr9pdFKwEm3hkeR?=
 =?us-ascii?Q?KbkNqkYnm7iIhRDlMvKgldvkfYb01xvPKgvQCOm/5Z9ulDy1fsIYr3JKhPt1?=
 =?us-ascii?Q?lb8JQEhDCUD/Jg2pNXZvT73w/iJSfxxASiInh3eo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81d2747-2442-4872-9c1a-08dc3f5643f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 09:58:11.9120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SG9Q5714B+nbvNi+OAByaQbseivovgAKLhRwDBDlWgPbS2cdUbaYr9nvqE0Jas9f7JYJEHnPe+OCGT+9oxVGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4794
X-Proofpoint-GUID: iTaZ8vtUKjKd7cnV-3Ba-b8fX7m4X1pi
X-Proofpoint-ORIG-GUID: iTaZ8vtUKjKd7cnV-3Ba-b8fX7m4X1pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02

>----------------------------------------------------------------------
>Changing the MAC address of the VFs are not available via devlink. Add
>the function handlers to set and get the HW address for the VFs.
>
>Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
> 3 files changed, 147 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c
>b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index 80dc5445b50d..39d4d79ac731 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf
>*pf)
> 	devlink_port_unregister(&pf->devlink_port);
> }
>
>+/**
>+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink
>+handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_get operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+
>+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
>+					  u8 *hw_addr, int *hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+{
>+	struct devlink_port_attrs *attrs =3D &port->attrs;
[Suman] I agree with Wojciech about using container_of:

>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	struct devlink *devlink =3D port->devlink;
>+	struct ice_pf *pf;
>+	struct ice_vf *vf;
>+	int vf_id;
>+
>+	pf =3D devlink_priv(devlink);
>+	pci_vf =3D &attrs->pci_vf;
>+	vf_id =3D pci_vf->vf;
>+
>+	vf =3D ice_get_vf_by_id(pf, vf_id);
>+	if (!vf) {
>+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
>+		return -EINVAL;
>+	}
>+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
>+	*hw_addr_len =3D ETH_ALEN;
>+
>+	ice_put_vf(vf);
>+	return 0;
>+}
>+
>+/**
>+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink
>+handler
>+ * @port: devlink port structure
>+ * @hw_addr: MAC address of the port
>+ * @hw_addr_len: length of MAC address
>+ * @extack: extended netdev ack structure
>+ *
>+ * Callback for the devlink .port_fn_hw_addr_set operation
>+ * Return: zero on success or an error code on failure.
>+ */
>+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
>+					  const u8 *hw_addr,
>+					  int hw_addr_len,
>+					  struct netlink_ext_ack *extack)
>+
>+{
>+	struct devlink_port_attrs *attrs =3D &port->attrs;
>+	struct devlink_port_pci_vf_attrs *pci_vf;
>+	struct devlink *devlink =3D port->devlink;
>+	struct ice_pf *pf;
>+	u8 mac[ETH_ALEN];
>+	int vf_id;
>+
>+	pf =3D devlink_priv(devlink);
>+	pci_vf =3D &attrs->pci_vf;
>+	vf_id =3D pci_vf->vf;
>+
>+	ether_addr_copy(mac, hw_addr);
>+
>+	return ice_set_vf_fn_mac(pf, vf_id, mac); }
>+
>+static const struct devlink_port_ops ice_devlink_vf_port_ops =3D {
>+	.port_fn_hw_addr_get =3D ice_devlink_port_get_vf_fn_mac,
>+	.port_fn_hw_addr_set =3D ice_devlink_port_set_vf_fn_mac, };
>+
> /**
>  * ice_devlink_create_vf_port - Create a devlink port for this VF
>  * @vf: the VF to create a port for
>@@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> 	devlink_port_attrs_set(devlink_port, &attrs);
> 	devlink =3D priv_to_devlink(pf);
>
>-	err =3D devlink_port_register(devlink, devlink_port, vsi->idx);
>+	err =3D devlink_port_register_with_ops(devlink, devlink_port,
>+					     vsi->idx, &ice_devlink_vf_port_ops);
> 	if (err) {
> 		dev_err(dev, "Failed to create devlink port for VF %d, error
>%d\n",
> 			vf->vf_id, err);
>diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
>b/drivers/net/ethernet/intel/ice/ice_sriov.c
>index 31314e7540f8..73cf1d9e9daa 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int
>vf_id, struct ifla_vf_info *ivi)
> 	return ret;
> }
>
>+/**
>+ * ice_set_vf_fn_mac
>+ * @pf: PF to be configure
>+ * @vf_id: VF identifier
>+ * @mac: MAC address
>+ *
>+ * program VF MAC address
>+ */
>+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac) {
>+	struct device *dev;
>+	struct ice_vf *vf;
>+	int ret;
>+
>+	dev =3D ice_pf_to_dev(pf);
>+	if (is_multicast_ether_addr(mac)) {
>+		dev_err(dev, "%pM not a valid unicast address\n", mac);
>+		return -EINVAL;
>+	}
[Suman] I would suggest put all the validation checks at the beginning of t=
he function.
>+
>+	vf =3D ice_get_vf_by_id(pf, vf_id);
[Suman] Any reason we are passing vf_id instead of the vf itself? If you de=
cide to pass vf itself please move the ether_addr_equal() check at the begi=
nning also.

>+	if (!vf)
>+		return -EINVAL;
>+
>+	/* nothing left to do, unicast MAC already set */
>+	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
>+	    ether_addr_equal(vf->hw_lan_addr, mac)) {
>+		ret =3D 0;
>+		goto out_put_vf;
>+	}
>+
>+	ret =3D ice_check_vf_ready_for_cfg(vf);
>+	if (ret)
>+		goto out_put_vf;
>+
>+	mutex_lock(&vf->cfg_lock);
>+
>+	/* VF is notified of its new MAC via the PF's response to the
>+	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
>+	 */
>+	ether_addr_copy(vf->dev_lan_addr, mac);
>+	ether_addr_copy(vf->hw_lan_addr, mac);
>+	if (is_zero_ether_addr(mac)) {
>+		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC
>*/
>+		vf->pf_set_mac =3D false;
>+		dev_info(dev, "Removing MAC on VF %d. VF driver will be
>reinitialized\n",
>+			 vf->vf_id);
>+	} else {
>+		/* PF will add MAC rule for the VF */
>+		vf->pf_set_mac =3D true;
>+		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be
>reinitialized\n",
>+			 mac, vf_id);
>+	}
>+
>+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>+	mutex_unlock(&vf->cfg_lock);
>+
>+out_put_vf:
>+	ice_put_vf(vf);
>+	return ret;
>+}
>+
> /**
>  * ice_set_vf_mac
>  * @netdev: network interface device structure diff --git
>a/drivers/net/ethernet/intel/ice/ice_sriov.h
>b/drivers/net/ethernet/intel/ice/ice_sriov.h
>index 346cb2666f3a..a03be184a806 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
>@@ -28,6 +28,7 @@
> #ifdef CONFIG_PCI_IOV
> void ice_process_vflr_event(struct ice_pf *pf);  int
>ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
>+int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
> int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);  int
>ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info
>*ivi); @@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev
>__always_unused *pdev,
> 	return -EOPNOTSUPP;
> }
>
>+static inline int
>+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
>+		  int __always_unused vf_id, u8 __always_unused *mac) {
>+	return -EOPNOTSUPP;
>+}
>+
> static inline int
> ice_set_vf_mac(struct net_device __always_unused *netdev,
> 	       int __always_unused vf_id, u8 __always_unused *mac)
>--
>2.39.3 (Apple Git-145)
>


