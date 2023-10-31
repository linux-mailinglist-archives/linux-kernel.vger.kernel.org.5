Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AF7DCE2B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjJaNrH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbjJaNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:47:06 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD7DE;
        Tue, 31 Oct 2023 06:47:03 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57f137dffa5so507123eaf.1;
        Tue, 31 Oct 2023 06:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698760023; x=1699364823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFyBX1wX1AQiQ51kpLHsbX36OHWqritzDOTQm1bvo+8=;
        b=NccLawyg4x4vyWf6Ad9ogypLczGDGEPKlu8WevQN5wQnjvtI47KgLidCF1PtnFHxKI
         kuGWFhkUl3dxTAwzTatr/ywWzjB3L2LNQp/aIoypR6CQuRVNaYXdQpyFZrJevWqDx00o
         rqbZcHRYBsHTd3yIeNFOVaAy4BLmRRdCdh6o+CtT20dvHaYlQJeQkUoh+heBpBS84iga
         PtYmaGWHZXIQyBn8SBdKGx3sLQ1yZ/jyyz+BE1wg/3SUvyL7j46RReqFrKA3PxWl86Wk
         icQbsi4/iBgrM3ebLepj0RuOMryx2JvsuJ7HZQS0ogs4Jw/4EwcauhRSgRo5CfcZVdrq
         Axvw==
X-Gm-Message-State: AOJu0Yz9vrrvBJ2fZCazd/7W6nt579zRwFr7bemJeEoWzFSNfsJYaGOc
        mneYCA8l9GdeU7092T2IQX/mzTyP5+xpem9igIg=
X-Google-Smtp-Source: AGHT+IEmvDYIDDOgfy4hgqjuXUBkF7k0jNoDifVFKEJA9+yUPHF0qdaITFsfKFqLg/DncYCJtHynob6JbN3EgLjxxFo=
X-Received: by 2002:a4a:c991:0:b0:586:7095:126d with SMTP id
 u17-20020a4ac991000000b005867095126dmr12308351ooq.0.1698760022778; Tue, 31
 Oct 2023 06:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <2187487.irdbgypaU6@kreacher> <7609686.EvYhyI6sBW@kreacher> <ZUDBnEJ41tc7nnka@kekkonen.localdomain>
In-Reply-To: <ZUDBnEJ41tc7nnka@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Oct 2023 14:46:51 +0100
Message-ID: <CAJZ5v0j_Uv=qVo6eFdz-Q7Ne7W7aTf9ThN128Ust+YEQQ9Gy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: scan: Extract MIPI DiSco for Imaging data
 into swnodes
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Oct 31, 2023 at 11:33 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On subject:
>
> s/DiSco/DisCo/

Huh

Thanks for catching this!

> On Fri, Oct 20, 2023 at 04:39:27PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add information extracted from the MIPI DiSco for Imaging device
>
> Ditto.
>
> > properties to software nodes created during the CSI-2 connection graph
> > discovery.
> >
> > Link: https://www.mipi.org/specifications/mipi-di
>
> This URL is broken. The correct URL is:
>
>         https://www.mipi.org/specifications/mipi-disco-imaging

OK

> > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/internal.h |    1
> >  drivers/acpi/mipi-di.c  |  240 +++++++++++++++++++++++++++++++++++++++++++++++-
>
> How about mipi-disco.c? I wouldn't mind having mipi-disco-imaging.c either.

Well, mipi-disco-imaging is a bit too long and the meaning of
mipi-disco would not be clear IMO.

What about mipi-disco-img?

[cut]

> > +     ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
> > +     if (ret > 0) {
> > +             unsigned long mask;
> > +             unsigned int i;
> > +
> > +             /*
> > +              * Total number of lanes here is clock lane + data lanes.
> > +              * Require that number to be low enough so they all can be
> > +              * covered by the bits in one byte.
> > +              */
> > +             BUILD_BUG_ON(BITS_PER_TYPE(u8) <= ARRAY_SIZE(port->data_lanes));
> > +
> > +             fwnode_property_read_u8_array(port_fwnode,
> > +                                           "mipi-img-lane-polarities",
> > +                                           val, 1);
> > +
> > +             for (mask = val[0], i = 0; i < num_lanes + 1; i++)
> > +                     port->lane_polarities[i] = test_bit(i, &mask);
>
> This works only up to seven lanes.

True, but then ACPI_DEVICE_CSI2_DATA_LANES is defined as 4.

> I guess this can be addressed later in
> case we get devices with 8 lanes. But adding a comment here (or where the
> maximum number of lanes is defined) that this needs to be fixed would be
> prudent to avoid introducing a bug later on.

The comment above talks about this, but I can add one more comment
next to the ACPI_DEVICE_CSI2_DATA_LANES definition.

> > +
> > +             port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LANE_POLARITIES)] =
> > +                             PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
> > +                                                          port->lane_polarities,
> > +                                                          1 + num_lanes);
> > +     } else {
> > +             acpi_handle_info(handle, "No lane polarity bytes\n");
> > +     }
> > +
> > +     swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
> > +             SOFTWARE_NODE("endpoint@0", swnodes->ports[port_index].ep_props,
> > +                           &swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)]);
> > +
> > +     if (port->crs_csi2_local)
> > +             init_csi2_port_local(adev, port, port_fwnode, ep_prop_index);
> > +}
> > +
> > +#define MIPI_IMG_PORT_PREFIX "mipi-img-port-"
> > +
> > +static struct fwnode_handle *get_mipi_port_handle(struct fwnode_handle *adev_fwnode,
> > +                                               unsigned int port_nr)
> > +{
> > +     char port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
> > +
> > +     if (snprintf(port_name, sizeof(port_name), "%s%u",
> > +                  MIPI_IMG_PORT_PREFIX, port_nr) >= sizeof(port_name))
> > +             return NULL;
> > +
> > +     return fwnode_get_named_child_node(adev_fwnode, port_name);
> > +}
> > +
> > +static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
> > +{
> > +     struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER };
> > +     struct acpi_device_software_nodes *swnodes = csi2->swnodes;
> > +     acpi_handle handle = csi2->handle;
> > +     struct fwnode_handle *adev_fwnode;
> > +     struct acpi_device *adev;
> > +     acpi_status status;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     /*
> > +      * Bail out if the swnodes are not available (either they have not been
> > +      * allocated or they have been assigned to the device already).
> > +      */
> > +     if (!swnodes)
> > +             return;
> > +
> > +     adev = acpi_fetch_acpi_dev(handle);
> > +     if (!adev)
> > +             return;
> > +
> > +     adev_fwnode = acpi_fwnode_handle(adev);
> > +
> > +     status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> > +     if (ACPI_FAILURE(status)) {
> > +             acpi_handle_info(handle, "Unable to get the path name\n");
> > +             return;
> > +     }
> > +
> > +     swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT] =
> > +                     SOFTWARE_NODE(buffer.pointer, swnodes->dev_props, NULL);
> > +
> > +     for (i = 0; i < swnodes->num_ports; i++) {
> > +             struct acpi_device_software_node_port *port = &swnodes->ports[i];
> > +             struct fwnode_handle *port_fwnode;
> > +
> > +             /*
> > +              * The MIPI DisCo for Imaging specification defines _DSD device
> > +              * properties for providing CSI-2 port parameters that can be
> > +              * accessed through the generic device properties framework.  To
> > +              * access them, it is first necessary to find the data node
> > +              * representing the port under the given ACPI device object.
> > +              */
> > +             port_fwnode = get_mipi_port_handle(adev_fwnode, port->port_nr);
> > +             if (!port_fwnode) {
> > +                     acpi_handle_info(handle,
> > +                                      "MIPI port name too long for port %u\n",
> > +                                      port->port_nr);
> > +                     continue;
> > +             }
> > +
> > +             init_csi2_port(adev, swnodes, port, port_fwnode, i);
> > +
> > +             fwnode_handle_put(port_fwnode);
> > +     }
> > +
> > +     ret = software_node_register_node_group(swnodes->nodeptrs);
> > +     if (ret < 0) {
> > +             acpi_handle_info(handle,
> > +                              "Unable to register software nodes (%d)\n", ret);
> > +             return;
> > +     }
> > +
> > +     adev->swnodes = swnodes;
> > +     adev_fwnode->secondary = software_node_fwnode(swnodes->nodes);
> > +
> > +     /*
> > +      * Prevents the swnodes from this csi2 entry from being assigned again
> > +      * or freed prematurely.
> > +      */
> > +     csi2->swnodes = NULL;
> > +}
> > +
> > +/**
> > + * acpi_mipi_init_crs_csi2_swnodes - Initialize _CRS CSI-2 software nodes
> > + *
> > + * Use MIPI DiSco for Imaging device properties to finalize the initialization
> > + * of CSI-2 software nodes for all ACPI device objects that have been already
> > + * enumerated.
> > + */
> > +void acpi_mipi_init_crs_csi2_swnodes(void)
> > +{
> > +     struct crs_csi2 *csi2, *csi2_tmp;
> > +
> > +     list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry)
> > +             init_crs_csi2_swnodes(csi2);
> > +}
> > +
> >  /**
> >   * acpi_mipi_crs_csi2_cleanup - Free _CRS CSI-2 temporary data
> >   */
> > Index: linux-pm/drivers/acpi/internal.h
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/internal.h
> > +++ linux-pm/drivers/acpi/internal.h
> > @@ -287,6 +287,7 @@ static inline void acpi_init_lpit(void)
> >
> >  void acpi_mipi_check_crs_csi2(acpi_handle handle);
> >  void acpi_mipi_scan_crs_csi2(void);
> > +void acpi_mipi_init_crs_csi2_swnodes(void);
> >  void acpi_mipi_crs_csi2_cleanup(void);
> >
> >  #endif /* _ACPI_INTERNAL_H_ */
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -2447,6 +2447,13 @@ static void acpi_scan_postponed_branch(a
> >
> >       acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> >                           acpi_bus_check_add_2, NULL, NULL, (void **)&adev);
> > +
> > +     /*
> > +      * Populate the ACPI _CRS CSI-2 software nodes for the ACPI devices that
> > +      * have been added above.
> > +      */
> > +     acpi_mipi_init_crs_csi2_swnodes();
> > +
> >       acpi_bus_attach(adev, NULL);
> >  }
> >
> > @@ -2516,11 +2523,12 @@ int acpi_bus_scan(acpi_handle handle)
> >               return -ENODEV;
> >
> >       /*
> > -      * Allocate ACPI _CRS CSI-2 software nodes using information extracted
> > +      * Set up ACPI _CRS CSI-2 software nodes using information extracted
> >        * from the _CRS CSI-2 resource descriptors during the ACPI namespace
> > -      * walk above.
> > +      * walk above and MIPI DiSco for Imaging device properties.
> >        */
> >       acpi_mipi_scan_crs_csi2();
> > +     acpi_mipi_init_crs_csi2_swnodes();
> >
> >       acpi_bus_attach(device, (void *)true);
> >
> > Index: linux-pm/include/acpi/acpi_bus.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/acpi_bus.h
> > +++ linux-pm/include/acpi/acpi_bus.h
> > @@ -366,10 +366,17 @@ struct acpi_device_data {
> >
> >  struct acpi_gpio_mapping;
> >
> > +#define ACPI_DEVICE_SWNODE_ROOT                      0
> > +
> >  #define ACPI_DEVICE_CSI2_DATA_LANES          4
> >
> >  #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH  8
> >
> > +enum acpi_device_swnode_dev_props {
> > +     ACPI_DEVICE_SWNODE_DEV_NUM_OF,
> > +     ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
> > +};
> > +
> >  enum acpi_device_swnode_port_props {
> >       ACPI_DEVICE_SWNODE_PORT_REG,
> >       ACPI_DEVICE_SWNODE_PORT_NUM_OF,
> > @@ -425,12 +432,14 @@ struct acpi_device_software_node_port {
> >
> >  /**
> >   * struct acpi_device_software_nodes - Software nodes for an ACPI device
> > + * @dev_props: Device properties.
> >   * @nodes: Software nodes for root as well as ports and endpoints.
> >   * @nodeprts: Array of software node pointers, for (un)registering them.
> >   * @ports: Information related to each port and endpoint within a port.
> >   * @num_ports: The number of ports.
> >   */
> >  struct acpi_device_software_nodes {
> > +     struct property_entry dev_props[ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES];
> >       struct software_node *nodes;
> >       const struct software_node **nodeptrs;
> >       struct acpi_device_software_node_port *ports;
> > @@ -455,6 +464,7 @@ struct acpi_device {
> >       struct acpi_device_data data;
> >       struct acpi_scan_handler *handler;
> >       struct acpi_hotplug_context *hp;
> > +     struct acpi_device_software_nodes *swnodes;
> >       const struct acpi_gpio_mapping *driver_gpios;
> >       void *driver_data;
> >       struct device dev;
> >
> >
> >
>
> --
> Regards,
>
> Sakari Ailus
>
